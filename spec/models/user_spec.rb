require 'rails_helper'

describe User do

  before do
    @user = create(:user)
    @post = create(:post, user: @user)
    @post2 = create(:post, user: @user)
  end

  describe "#favorited(post)" do
    it "returns `nil` if the user has not favorited the post" do
      expect( @user.favorited(@post) ).to be_nil
    end

    it "returns the appropriate favorite if it exists" do
      @user.favorites.create(post: @post, user: @user)
      expect( @user.favorited(@post) ).to be
    end

    it "returns `nil` if the user has favorited another post" do
      @user.favorites.create(post: @post, user: @user)
      expect( @user.favorited(@post) ).to be
      expect( @user.favorited(@post2) ).to be_nil
    end
  end

  describe ".top_rated" do

    before do
     @user1 = create(:user)
     post = create(:post, user: @user1)
     create(:comment, user: @user1, post: post)

     @user2 = create(:user)
     post = create(:post, user: @user2)
     2.times { create(:comment, user: @user2, post: post) }
    end

    it "returns users ordered by comments + posts" do
     expect( User.top_rated ).to eq([@user2, @user1])
    end

    it "stores a `posts_count` on user" do
     users = User.top_rated
     expect( users.first.posts_count ).to eq(1)
    end

    it "stores a `comments_count` on user" do
     users = User.top_rated
     expect( users.first.comments_count ).to eq(2)
    end

  end

end