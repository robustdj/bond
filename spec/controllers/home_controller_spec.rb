require 'spec_helper'

describe HomeController do
  describe "GET index" do
    it "should get friends from the graph api" do
      controller.instance_variable_set("@graph", Object.new)
      controller.should_receive(:get_my_friends).with(assigns(:graph))
      get :index
    end
  end

  describe "GET search" do
    it "should query friends" do
      controller.instance_variable_set("@graph", Object.new)
      controller.should_receive(:search_my_friends).with(assigns(:graph), "mark")
      get :search, :query => "mark"
    end

    it "should use the index templete" do
      controller.stub :search_my_friends
      get :search
      response.should render_template(:index)
    end

  end

  describe "GET likes_in_common" do
    it "should get query graph api for likes in common" do
      friend_id = 123
      controller.instance_variable_set("@graph", Object.new)
      controller.should_receive(:get_friend).with(assigns(:graph), friend_id)
      controller.should_receive(:get_likes_in_common).with(assigns(:graph), "me", friend_id)
      controller.should_receive(:get_likes).with(assigns(:graph), anything())
      get :likes_in_common, :friend_id => friend_id
    end
  end
end
