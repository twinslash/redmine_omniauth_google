get 'oauth_google', :to => 'redmine_oauth#oauth_google'
get 'oauth2callback', :to => 'redmine_oauth#oauth_google_callback', :as => 'oauth_google_callback'
