class HomeController < ApplicationController
  include Facebook

  def index
    #@access_token = @facebook_cookies['access_token']
  end

  def search
    @friends = search_my_friends(@graph, params[:query])
  end

  def likes_in_common
    @likes_in_common = get_likes_in_common(@graph, "me", params[:friend_id])
  end
end
