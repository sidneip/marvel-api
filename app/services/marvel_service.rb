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
      Character.create_with(name: character['name'], description: character['description']).find_or_create_by(code: character['id'])
    end
  end

  def get_characters(page = 1)
    offset = page * 100
    response = self.class.get("/characters", query: { apikey: public_key, hash: hash, ts: 1, limit: 100, offset: offset})
    raise AuthError if response.code != 200
    response
  end

  def get_character(id)
    response = self.class.get("/characters/#{id}", query: { apikey: public_key, hash: hash, ts: 1})
    raise AuthError if response.code != 200
    response
  end

  def get_all_characters(page = 1, characters = [])
    response = get_characters(page)
    pages = (response['data']['total'].to_f / 100.to_f).ceil
    results = (characters << response['data']['results']).flatten!
    get_all_characters(page + 1, results) if page < pages
    characters.flatten
  end

  private

  def hash
    Digest::MD5.hexdigest "1#{private_key}#{public_key}"
  end
end
