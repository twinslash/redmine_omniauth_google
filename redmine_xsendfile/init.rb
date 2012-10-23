require 'redmine'

require 'xsendfile_patch'
ActionController::DataStreaming.send(:include, XsendfilePatch)

Redmine::Plugin.register :redmine_xsendfile do
  name 'XSendfile plugin'
  author 'Just Lest'
  description ''
  version '0.0.1'

  settings :default => {'mode' => nil},
           :partial => 'settings/xsendfile_settings'
end
