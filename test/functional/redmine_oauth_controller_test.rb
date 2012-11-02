require File.expand_path('../../test_helper', __FILE__)

class RedmineOauthControllerTest < ActionController::TestCase

  def setup
    @default_user_credentials = { firstname: 'Cool',
                                  lastname: 'User',
                                  mail: 'user@somedomain.com'}
    @default_response_body = {verified_email: true,
                              name: 'Cool User',
                              given_name: 'Cool',
                              family_name: 'User',
                              email: 'user@somedomain.com'}
    User.current = nil
    Setting.openid = '1'
    OAuth2::AccessToken.any_instance.stubs(get: OAuth2::Response.new(nil))
    OAuth2::Client.any_instance.stubs(get_token: OAuth2::AccessToken.new('code', 'redirect_uri'))
  end

  #creates a new user with the credentials listed in the options and fills in the missing data by default data
  def new_user options = {}
    User.where(@default_user_credentials.merge(options)).delete_all
    user = User.new @default_user_credentials.merge(options)
    user.login = options[:login] || 'cool_user'
    user
  end

  #creates a new user with the credentials listed in the options and fills in the missing data by default data
  def set_response_body_stub options = {}
    OAuth2::Response.any_instance.stubs(body: @default_response_body.merge(options).to_json)
  end

  def test_oauth_google_with_disabled_openid
    Setting.openid = false
    get :oauth_google
    assert_redirected_to signin_path
  end

  def test_oauth_google_callback_with_oauth_for_existing_non_active_user
    Setting.self_registration = '2'
    user = new_user status: User::STATUS_REGISTERED
    assert user.save
    set_response_body_stub
    get :oauth_google_callback
    assert_redirected_to signin_path
  end

  def test_oauth_google_callback_with_oauth_for_existing_active_user
    user = new_user
    user.activate
    assert user.save
    set_response_body_stub
    get :oauth_google_callback
    assert_redirected_to controller: 'my', action: 'page'
  end

  def test_oauth_google_callback_with_omniauth_for_new_user_with_valid_credentials_and_sefregistration_enabled
    Setting.self_registration = '3'
    set_response_body_stub
    get :oauth_google_callback
    assert_redirected_to controller: 'my', action: 'account'
    user = User.find_by_mail(@default_response_body[:email])
    assert_equal user.mail, @default_response_body[:email]
    assert_equal user.login, email_prefix(@default_response_body[:email])
  end

  def test_oauth_google_callback_with_omniauth_for_new_user_with_valid_credentials_and_sefregistration_disabled
    Setting.self_registration = '2'
    set_response_body_stub
    get :oauth_google_callback
    assert_redirected_to signin_path
  end

  def test_oauth_google_callback_with_oauth_for_new_user_with_invalid_oauth_provider
    Setting.self_registration = '3'
    set_response_body_stub verified_email: false
    get :oauth_google_callback
    assert_redirected_to signin_path
  end

  #def test_login_with

  #assert existing_user.save!
end