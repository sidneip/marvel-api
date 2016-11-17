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

    assert_response :success
  end

  test "should show api_character" do
    get api_character_url(@character), as: :json
    assert_response :success
  end

  test "should update api_character" do
    patch api_character_url(@character), params: { character: { name: 'abc' } }, as: :json
    assert_response 201
  end

  test "should destroy api_character" do
    assert_difference('Character.count', -1) do
      delete api_character_url(@character), as: :json
    end

    assert_response 204
  end
end
