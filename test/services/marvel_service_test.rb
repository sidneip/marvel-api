require 'test_helper'
class MarvelServiceTest < Minitest::Test
  def setup
    @service = MarvelService.new('305fe92923c00364a31c829229809155', 'f7843ea0d35c0167b65a808edb9c6cf3a8120d36')
  end

  def test_create_service_required_public_and_private_key
    assert_raises ArgumentError do
      MarvelService.new(1)
    end
  end

  def test_set_public_and_private_key
    assert_equal '305fe92923c00364a31c829229809155', @service.public_key
    assert_equal 'f7843ea0d35c0167b65a808edb9c6cf3a8120d36', @service.private_key
  end

  def test_get_characters_return_status_200
    response = @service.import_characters
    assert_equal 200, response.code
  end

  def test_import_characters_should_call_get_characters
    spy_get_characters = Spy.on(@service, :get_characters).and_return([])
    @service.import_characters
    spy_get_characters.has_been_called?
  end

end
