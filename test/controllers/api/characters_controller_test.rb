require 'test_helper'

class Api::CharactersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @character = characters(:one)
  end

  test "should get index" do
    get api_characters_url, as: :json
    assert_response :success
  end

  test "should create api_character" do
    assert_difference('Character.count') do
      post api_characters_url, params: { character: { name: 'teste', description: 'abc' } }, as: :json
    end

    assert_response :succes
  end

  test "should show api_character" do
    get api_character_url(@character), as: :json
    assert_response :success
  end

  test "should get edit" do
    get edit_api_character_url(@character), as: :json
    assert_response :success
  end

  test "should update api_character" do
    patch api_character_url(@character), params: { character: {  } }, as: :json
    assert_redirected_to api_character_url(@character)
  end

  test "should destroy api_character" do
    assert_difference('Character.count', -1) do
      delete api_character_url(@character), as: :json
    end

    assert_redirected_to api_characters_url
  end
end
