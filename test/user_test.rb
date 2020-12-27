require "test_helper"

class UserTest < BaseTest
  test "should set as current" do
    @user = User.create(name: "John")
    Mongoid::Userstamps::Config.set_current_user(User, @user)
    assert_equal @user, Mongoid::Userstamps::Config.current_user(User)
    assert @user.current?
    assert_equal @user, User.current

    @user2 = User.create(name: "Johnny")
    User.current = @user2
    assert @user2.current?
    assert_equal @user2, Mongoid::Userstamps::Config.current_user(User)
  end

  test "reader" do
    assert_equal :current_person, Person.userstamps_user.reader
    assert_equal :current_admin, User.userstamps_user.reader
  end

  test "sudo" do
    @user = User.create(name: "John")
    @user2 = User.create(name: "Johnny")
    User.current = @user
    post = nil
    User.sudo @user2 do
      post = Post.create(title: "Hello")
    end

    assert_equal @user, User.current
    assert_equal @user2, post.created_by
  end
end
