module Helpers
  module Checker
    def allowed_domain_for? email
      allowed_domains = Setting.plugin_redmine_omniauth_google[:allowed_domains]
      return unless allowed_domains
      allowed_domains = allowed_domains.split
      return true if allowed_domains.empty?
      allowed_domains.index(parse_email(email)[:domain])
    end
  end
end