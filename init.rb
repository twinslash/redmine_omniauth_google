require 'redmine'
require_dependency 'redmine_omniauth_google/hooks'

Redmine::Plugin.register :redmine_omniauth_google do
  name 'Redmine Omniauth Google plugin'
  author 'Dmitry Kovalenok, 9yUXEf6O'
  description 'This is a plugin for Redmine registration through google'
  version '0.0.1'
  url 'https://github.com/9yUXEf6O/redmine_omniauth_google'
  author_url 'https://github.com/9yUXEf6O'

  settings :default => {
    :client_id => "",
    :client_secret => "",
    :oauth_autentification => false,
    :allowed_domains => ""
  }, :partial => 'settings/google_settings'
end
