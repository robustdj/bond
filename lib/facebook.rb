module Facebook
  def get_my_friends(graph)
    graph.try(:get_connections, "me", "friends")
  end

  def search_my_friends(graph, name)
    friends = graph.get_connections "me", "friends"
    friends.select{|friend| friend["name"].match /#{name}/i}
  end

  def get_friend(graph, friend_id)
    graph.get_object friend_id
  end

  def get_likes(graph, likes_ids)
    likes_ids.nil? ? [] : graph.get_objects(likes_ids)
  end

  def get_likes_in_common(graph, friend, friend2)
    friend_likes = graph.get_connections friend, "likes"
    friend2_likes = graph.get_connections friend2, "likes"
    friend_likes.map!{|like| like["id"]}
    friend2_likes.map!{|like| like["id"]}
    friend_likes & friend2_likes
  end
end
