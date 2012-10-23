module RedmineOmniauthGoogle
  module Hooks
    class ViewAccountLoginBottomHook < Redmine::Hook::ViewListener
      # def view_account_login_bottom context = {}
      #   context[:controller].send(:render_to_string, {
      #     partial: "hooks/redmine_omniauth_google/view_account_login_bottom",
      #     locals: context
      #     })
      # end
      render_on :view_account_login_bottom,
                partial: "hooks/redmine_omniauth_google/view_account_login_bottom"
    end
  end
end