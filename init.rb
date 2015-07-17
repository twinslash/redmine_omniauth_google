require 'redmine'
require_dependency 'redmine_omniauth_google/hooks'

Redmine::Plugin.register :redmine_omniauth_google do
  name 'Redmine Omniauth Google plugin'
  author 'Dmitry Kovalenok'
  description 'This is a plugin for Redmine registration through google'
  version '0.0.1'
  url 'https://github.com/twinslash/redmine_omniauth_google'
  author_url 'http://twinslash.com'

  settings :default => {
    :client_id => "",
    :client_secret => "",
    :oauth_autentification => false,
    :allowed_domains => "",
    :ignore_self_registration => ""
  }, :partial => 'settings/google_settings'
end
