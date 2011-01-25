class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :init_oauth, :parse_facebook_cookies

  def init_oauth
    @oauth ||= Koala::Facebook::OAuth.new
  end

  def parse_facebook_cookies
    @facebook_cookies ||= @oauth.get_user_info_from_cookie(cookies)
  end
end
