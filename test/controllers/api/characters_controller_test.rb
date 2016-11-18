require 'test_helper'

class Api::CharactersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @character = characters(:one)
  end

  test "should get index" do
    get api_characters_url, as: :json
    assert_response :success
  end

  test 'should return characters' do
    get api_characters_url, as: :json
    body = JSON.parse @response.body
    assert Character.all.size, body.size
  end

  test 'should render character first in json respose' do
    get api_characters_url, as: :json
    body = JSON.parse @response.body
    assert Character.first.name, body['results'][0]['name']
  end

  test "should create api_character" do
    assert_difference('Character.count') do
      post api_characters_url, params: { character: { name: 'teste', description: 'abc' } }, as: :json
    end

    assert_response :success
  end

  test  "should create new character" do
    total = Character.all.size
    post api_characters_url, params: { character: {name: 'teste2121', description: 'a1'} }, as: :json
    assert_equal total+1, Character.all.size
    assert_equal 'teste2121', Character.last.name
    assert_response 201
  end

  test "should show character" do
    get api_character_url(@character), as: :json
    assert_response :success
  end

  test "should render character" do
    get api_character_url(@character), as: :json
    body = JSON.parse @response.body
    assert_equal @character.id, body["id"]
    assert_equal @character.name, body["name"]
  end

  test "should return 404 if character not exist" do
    get api_character_url('asd1'), as: :json
    assert_response :not_found
  end

  test "should update character response success" do
    patch api_character_url(@character), params: { character: { name: 'updatename' } }, as: :json
    assert_response 201
  end

  test "should update name" do
    patch api_character_url(@character), params: { character: { name: 'testeupdate' } }, as: :json
    assert_equal 'testeupdate', @character.reload.name
  end

  test "should destroy api_character" do
    assert_difference('Character.count', -1) do
      delete api_character_url(@character), as: :json
    end

    assert_response 204
  end
end
