require 'test_helper'

class LoginsControllerTest < ActionDispatch::IntegrationTest

  def test_return_success_in_get_login_page
    get new_login_url
    assert_response :success
  end

  def test_login_with_valid_credentials
    Spy.on_instance_method(MarvelService, :import_characters).and_return([])
    post logins_url, params: {login: {public_key: "abc", private_key: "123"}}
    assert_redirected_to characters_path
  end

  def test_login_with_valid_credentials_save_session
    Spy.on_instance_method(MarvelService, :import_characters).and_return([])
    post logins_url, params: {login: {public_key: "abc", private_key: "123"}}
    assert_equal "abc", session[:public_key]
    assert_equal "123", session[:private_key]
  end

  def test_login_with_invalid_credentials_redirect_error_auth
    post logins_url, params: {login: {public_key: "abc", private_key: "123"}}
    assert_redirected_to auth_error_logins_url
  end

end
