module Helpers
  module MailHelper
    def email_prefix email
      prefix = email.match(/(.+?)@/) if email
      prefix[1] if prefix
    end
  end
end