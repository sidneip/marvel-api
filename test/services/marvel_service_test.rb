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
    VCR.use_cassette(:get_character) do
      response = @service.get_characters
      assert 200, response.code
    end
  end

  def test_get_characters_return_array_results
    VCR.use_cassette(:get_character) do
      response = @service.get_characters
      assert response.has_key?("data")
      assert response["data"].has_key?("results")
    end
  end

  def test_get_page_in_get_characters
    VCR.use_cassette(:import_characters) do
      response = @service.get_characters(2)
      assert_equal 200, response["data"]["offset"]
    end
  end

  def test_import_thumbnail
    VCR.use_cassette(:import_characters) do
      response = @service.import_characters
      character = Character.last
      assert_equal "http://i.annihil.us/u/prod/marvel/i/mg/c/d0/4ced5ab9078c9.jpg", character.thumbnail
    end
  end

  def test_raise_auth_error_authenticate_invalid
    assert_raises AuthError do
      MarvelService.new('1', '2').get_characters
    end
  end

  def test_get_character_return_status_200
    VCR.use_cassette(:get_character, record: :new_episodes) do
      response = @service.get_character(1011334)
      assert_equal 200, response.code
    end
  end

  def test_get_character_return_character
    VCR.use_cassette(:get_character, record: :new_episodes) do
      response = @service.get_character(1011334)
      assert_equal response['data']['results'][0]['name'], '3-D Man'
    end
  end

  def test_get_character_not_exist
    response = @service.get_character('abc123')
    assert_equal response.code, 404
  end

  def test_import_characters_should_call_get_characters
    VCR.use_cassette(:import_characters) do
      spy_get_characters = Spy.on(@service, :get_characters).and_return(
        {"data" => { "total" => 1, "results" => [] } } 
      )
      @service.import_characters
      spy_get_characters.has_been_called?
    end
  end

  def test_import_characters_should_call_create_with_and_find_or_create_by
    VCR.use_cassette(:import_characters) do
      spy_character = Spy.on(Character, :create_with).and_call_through
      size = @service.get_all_characters.size
      @service.import_characters
      spy_character.has_been_called?
      assert_equal size, spy_character.calls.size
    end
  end

  def test_import_characters_create_characters
    VCR.use_cassette(:import_characters) do
      size = @service.get_all_characters.size
      Character.destroy_all
      @service.import_characters
      assert_equal Character.all.size, size
    end
  end

  def test_get_all_characters_return_all_characters_in_api
    VCR.use_cassette(:import_characters) do
      characters = @service.get_all_characters
      total = @service.get_characters['data']['total']
      assert_equal total, characters.size
    end
  end

end
