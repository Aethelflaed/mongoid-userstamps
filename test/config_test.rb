require "test_helper"

class ConfigTest < BaseTest
  class ModelClass
    def self.userstamps_model
      self
    end

    def self.user_model
      Mongoid::Userstamps::Config.user_classes.last
    end

    def self.set_user_model!
      @@user_model = user_model
    end
  end
  class UserClass
  end

  teardown do
    Mongoid::Userstamps::Config.model_classes.delete(ModelClass)
    Mongoid::Userstamps::Config.user_classes.delete(UserClass)
  end

  test "should config using block" do
    Mongoid::Userstamps.config do |c|
      c.created_name = :creator
      c.updated_name = :updater
      c.deleted_name = :deleter
    end
    assert_equal :creator, Mongoid::Userstamps::Config.created_name
    assert_equal :updater, Mongoid::Userstamps::Config.updated_name
    assert_equal :deleter, Mongoid::Userstamps::Config.deleted_name
  end

  test "current_user" do
    Mongoid::Userstamps::Config.set_current_user(Mongoid, "test")
    assert_equal "test", Mongoid::Userstamps::Config.current_user(Mongoid)
  end

  test "add_model_class" do
    assert_difference(-> { Mongoid::Userstamps::Config.model_classes.count }) do
      Mongoid::Userstamps::Config.add_model_class(ModelClass)
    end
  end

  test "add_user_class" do
    Mongoid::Userstamps::Config.add_model_class(ModelClass)
    Mongoid::Userstamps::Config.add_user_class(UserClass)
    assert_equal UserClass, ModelClass.user_model
  end
end
