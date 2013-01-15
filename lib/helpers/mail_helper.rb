module Helpers
  module MailHelper
    def parse_email email
      email_data = email && email.is_a?(String) ? email.match(/(.*?)@(.*)/) : nil
      {:login => email_data[1], :domain => email_data[2]} if email_data
    end
  end
end
