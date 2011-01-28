require File.join(Rails.root, 'lib/facebook')

class HomeController < ApplicationController
  include Facebook

  def index
    @friends = @graph.try(:get_connections, "me", "friends")
  end

  def search
    @friends = search_my_friends(@graph, params[:query])
    render "index"
  end

  def likes_in_common
    @friend = @graph.get_object params[:friend_id]
    likes_ids = get_likes_in_common(@graph, "me", params[:friend_id])
    @likes_in_common = likes_ids.blank? ? [] : @graph.get_objects(likes_ids)
  end

end
