module ApplicationHelper
  def character_image(response)
    thumbnail = response['data']['results'][0]['thumbnail']
    "#{thumbnail['path']}.#{thumbnail['extension']}"
  end
end
