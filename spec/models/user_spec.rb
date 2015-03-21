require 'rails_helper'

describe User do

  include TestFactories

  before do
    @post = associated_post
    @post2 = associated_post
    @user = authenticated_user
    @comment = Comment.new(body: 'My comment', post: @post, user_id: 10000)
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
end