class MarvelService
  attr_accessor :public_key, :private_key
  include HTTParty
  base_uri $MARVEL_CONFIG['url']
  format :json

  def initialize(public_key, private_key)
    @public_key  =  public_key
    @private_key =  private_key
  end
  
  def import_characters
    get_all_characters.each do |character|
      thumb = character.try(:[], 'thumbnail')
      Character.create_with(
        name: character['name'], 
        description: character['description'],
        thumbnail: get_thumbnail(thumb)
      ).find_or_create_by(
        code: character['id']
      )
    end
  end

  def get_characters(page = 0)
    offset = page * 100
    response = self.class.get("/characters", query: { apikey: public_key, hash: hash, ts: 1, limit: 100, offset: offset})
    raise AuthError if [409, 401, 405, 403].include?(response.code)
    response
  end

  def get_character(id)
    response = self.class.get("/characters/#{id}", query: { apikey: public_key, hash: hash, ts: 1})
    raise AuthError if [409, 401, 405, 403].include?(response.code)
    response
  end

  def get_character_stories(id)
    stories = []
    response = self.class.get("/characters/#{id}/stories", query: { apikey: public_key, hash: hash, ts: 1, offset: 1})
    raise AuthError if [409, 401, 405, 403].include?(response.code)

    pages = (response['data']['total'] / 100).ceil
    (0..pages).each do |page|
      offset = page * 100
      response = self.class.get("/characters/#{id}/stories", query: { apikey: public_key, hash: hash, ts: 1, offset: offset})
      response['data']['results'].each do |story|
        thumb = story.try(:[], 'thumbnail')
        stories << StorySerializer.new(name: story['title'], description: story['description'], thumbnail: get_thumbnail(thumb))
      end
    end
    stories
  end

  def get_all_characters(page = 0, characters = [])
    response = get_characters(page)
    pages = (response['data']['total'] / 100).ceil
    results = (characters << response['data']['results']).flatten!
    get_all_characters(page + 1, results) if page <= pages
    characters.flatten
  end

  private

  def get_thumbnail(thumb)
    "#{thumb.try(:[],'path')}.#{thumb.try(:[],'extension')}"
  end

  def hash
    Digest::MD5.hexdigest "1#{private_key}#{public_key}"
  end
end
