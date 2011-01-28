require 'spec_helper'

describe HomeController do
  describe "GET index" do
    it "should get friends from the graph api" do
      controller.instance_variable_set("@graph", Object.new)
      assigns(:graph).should_receive(:get_connections).with("me", "friends")
      get :index
    end

    it "should not raise an exception when graph is nil" do
      expect { get :index }.to_not raise_exception
      assigns(:friends).should be_nil
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
      controller.instance_variable_set("@graph", Object.new)
      assigns(:graph).stub(:get_object)
      assigns(:graph).stub(:get_objects)
      controller.should_receive(:get_likes_in_common).with(assigns(:graph), "me", 123)
      get :likes_in_common, :friend_id => 123
    end
  end
end
