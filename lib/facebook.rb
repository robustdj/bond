module Facebook
  def search_my_friends(graph, name)
    friends = graph.get_connections "me", "friends"
    friends.select{|friend| friend["name"].match /#{name}/i}
  end

  def get_likes_in_common(graph, friend, friend2)
    friend_likes = graph.get_connections friend, "likes"
    friend2_likes = graph.get_connections friend2, "likes"
    friend_likes.map!{|like| like["id"]}
    friend2_likes.map!{|like| like["id"]}
    friend_likes & friend2_likes
  end
end
