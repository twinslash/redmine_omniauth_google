require File.expand_path('../../test_helper', __FILE__)

class RedmineOauthControllerTest < ActionController::TestCase
  def setup
    User.current = nil
    Setting.openid = '1'
    OAuth2::AccessToken.any_instance.stubs(get: OAuth2::Response.new(nil))
    OAuth2::Client.any_instance.stubs(get_token: OAuth2::AccessToken.new('code', 'redirect_uri'))
  end
  def set_response_body_stub body
    OAuth2::Response.any_instance.stubs(body: body.to_json)
  end

  def new_user options = nil
    user_credentials = {:firstname => 'Cool',
                        :lastname => 'User',
                        :mail => 'user@somedomain.com'}.merge(options)
    user = User.new(user_credentials)
    user.login = options[:login] || 'cool_user'
    user
  end

  def test_login_with_omniauth_for_new_user
    Setting.self_registration = '3'
    user
    set_response_body_stub({verified_email: "true", name: [new_user.firstname, new_user.lastname]*" ", given_name: new_user.firstname, family_name: new_user.lastname, email: new_user.mail})
    get :oauth_google_callback, :email => new_user.mail
    assert_redirected_to controller: 'my', action: 'account'
  end

  def test_login_with_invalid_oauth_provider
    Setting.self_registration = '0'

  end

  #assert existing_user.save!
end