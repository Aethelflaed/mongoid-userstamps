require "test_helper"

class ModelTest < BaseTest
  setup do
    @user = User.create(name: "John")
    @user2 = User.create(name: "Johnny")
    Mongoid::Userstamps::Config.set_current_user(User, @user)
    @person = Person.create(name: "Doe")
    @person2 = Person.create(name: "Doe..")
    Mongoid::Userstamps::Config.set_current_user(Person, @person)
  end

  test "should set created_by and updated_by on creation" do
    @post = Post.create(title: "Hello")
    assert_equal @user, @post.created_by
    assert_equal @user, @post.updated_by
  end

  test "model with user_model" do
    assert_equal "Person", Comment.relations["updated_by"].class_name
  end

  test "set_created_by" do
    @post = Post.new
    @post.set_created_by
    assert_equal @user, @post.created_by

    @post = Post.new
    @post.created_by = @user2
    @post.set_created_by
    assert_equal @user2, @post.created_by

    Mongoid::Userstamps::Config.set_current_user(User, nil)
    @post = Post.new
    @post.set_created_by
    assert_nil @post.created_by
  end

  test "set_updated_by" do
    @post = Post.new
    @post.set_updated_by
    assert_equal @user, @post.updated_by

    @post = Post.new
    @post.updated_by = @user2
    @post.set_updated_by
    assert_equal @user2, @post.updated_by

    Mongoid::Userstamps::Config.set_current_user(User, nil)
    @post = Post.new
    @post.set_updated_by
    assert_nil @post.updated_by
  end

  test "set_deleted_by" do
    @comment = Comment.new
    @comment.set_deleted_by
    assert_equal @person, @comment.deleted_by

    @comment = Comment.new
    @comment.deleted_by = @person2
    @comment.set_deleted_by
    assert_equal @person2, @comment.deleted_by

    Mongoid::Userstamps::Config.set_current_user(Person, nil)
    @comment = Comment.new
    @comment.set_deleted_by
    assert_nil @comment.deleted_by
  end
end
