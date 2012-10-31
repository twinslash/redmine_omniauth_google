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

  def test_login_with_omniauth_for_new_user
    Setting.self_registration = '3'
    user_credentials = {:firstname => 'Cool',
                        :lastname => 'User',
                        :mail => 'user@somedomain.com'}
    User.where(user_credentials).delete_all
    new_user = User.new(user_credentials)
    new_user.login = 'cool_user'
    
    set_response_body_stub({verified_email: "true", name: [new_user.firstname, new_user.lastname]*" ", given_name: new_user.firstname, family_name: new_user.lastname, email: new_user.mail})
    get :oauth_google_callback, :email => new_user.mail
    assert_redirected_to controller: 'my', action: 'account'
  end

  #assert existing_user.save!
end