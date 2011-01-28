require File.join(Rails.root, 'lib/facebook')

class HomeController < ApplicationController
  include Facebook

  def index
    @friends = get_my_friends(@graph)
  end

  def search
    @friends = search_my_friends(@graph, params[:query])
    render "index"
  end

  def likes_in_common
    @friend = get_friend(@graph, params[:friend_id])
    likes_ids = get_likes_in_common(@graph, "me", params[:friend_id])
    @likes_in_common = get_likes(@graph, likes_ids)
  end
end
