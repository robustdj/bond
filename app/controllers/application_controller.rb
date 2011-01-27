class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :init_oauth, :parse_facebook_cookies

  def init_oauth
    @oauth ||= Koala::Facebook::OAuth.new(root_url)
    session['code'] = params['code'] if params['code']
    init_graph
  end

  def parse_facebook_cookies
    @facebook_cookies ||= @oauth.get_user_info_from_cookie(cookies)
  end

  def init_graph
    @graph = Koala::Facebook::GraphAPI.new(@oauth.get_access_token(session['code'])) if session['code']
  end
end
