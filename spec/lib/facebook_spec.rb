require 'spec_helper'
require 'facebook'

describe Facebook do
  include Facebook

  let!(:graph) { Object.new }

  describe "#search_my_friends" do
    before do
      graph.stub(:get_connections).with("me", "friends").and_return([
        {"name"=>"Justine Wyatt", "id"=>"100001019328165"},
        {"name"=>"Kevin Justiniano", "id"=>"100001256556912"},
        {"name"=>"Maisha Garland", "id"=>"100001340119826"},
        {"name"=>"Justin Connors", "id"=>"100001452088948"},
        {"name"=>"Mila Kunis", "id"=>"100001537887737"},
        {"name"=>"Chanel Lee", "id"=>"100001746778506"},
        {"name"=>"Justin Chef", "id"=>"100001814390908"},
        {"name"=>"Grace Connoly", "id"=>"100001961074679"}])
    end

    it "should find friends given a search string" do
      expected_result = search_my_friends(graph, "Justin")
      expected_result.should include(
        {"name"=>"Justine Wyatt", "id"=>"100001019328165"},
        {"name"=>"Kevin Justiniano", "id"=>"100001256556912"},
        {"name"=>"Justin Connors", "id"=>"100001452088948"},
        {"name"=>"Justin Chef", "id"=>"100001814390908"})
      expected_result.size.should == 4
    end

    it "should find friends given a search string and be case insensitive" do
      expected_result = search_my_friends(graph, "JuST")
      expected_result.should include(
        {"name"=>"Justine Wyatt", "id"=>"100001019328165"},
        {"name"=>"Kevin Justiniano", "id"=>"100001256556912"},
        {"name"=>"Justin Connors", "id"=>"100001452088948"},
        {"name"=>"Justin Chef", "id"=>"100001814390908"})
      expected_result.size.should == 4
    end

    it "should find no friends when searching for a name that doesn't match" do
      search_my_friends(graph, "John").should be_blank
    end
  end

  describe "#get_likes_in_common" do
    before do
      @me = {"name"=>"Derrick Camerino", "id"=>"202002813390902"}
      @kobe = {"name"=>"Kobe Bryant", "id"=>"436202593396533"}
      @mike = {"name"=>"Michael Jordan", "id"=>"869026893376023"}
      graph.stub(:get_connections).with("me", "likes").and_return([
        {"name"=>"Ugly Duckling",
          "category"=>"Musician/band",
          "id"=>"108219325866594",
          "created_time"=>"2010-04-29T05:21:55+0000"},
        {"name"=>"Binary Star",
          "category"=>"Musician/band",
          "id"=>"108173822537544",
          "created_time"=>"2010-04-29T05:21:55+0000"},
        {"name"=>"Self Scientific",
          "category"=>"Music",
          "id"=>"104641836243368",
          "created_time"=>"2010-04-29T05:21:55+0000"}])
    end

    it "should return a list of things in common between two friends" do
      graph.stub(:get_connections).with(@kobe["id"], "likes").and_return([
        {"name"=>"Ugly Duckling",
          "category"=>"Musician/band",
          "id"=>"108219325866594",
          "created_time"=>"2010-04-29T05:21:55+0000"},
        {"name"=>"Sound providers",
          "category"=>"Musician/band",
          "id"=>"110081852347931",
          "created_time"=>"2010-04-29T05:21:55+0000"},
        {"name"=>"Self Scientific",
          "category"=>"Music",
          "id"=>"104641836243368",
          "created_time"=>"2010-04-29T05:21:55+0000"}])
      get_likes_in_common(graph, "me", @kobe["id"]).should == [
        {"name"=>"Ugly Duckling", "category"=>"Musician/band", "id"=>"108219325866594" },
        {"name"=>"Self Scientific", "category"=>"Music", "id"=>"104641836243368" }
      ]
    end

    it "should return an empty array when nothing in common" do
      graph.stub(:get_connections).with(@mike["id"], "likes").and_return([
        {"name"=>"Michael Jackson",
          "category"=>"Music",
          "id"=>"938621409302368",
          "created_time"=>"2010-04-29T05:21:55+0000"}])
      get_likes_in_common(graph, "me", @mike["id"]).should be_blank
    end
  end
end

