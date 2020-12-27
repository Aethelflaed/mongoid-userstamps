require "test_helper"

module Mongoid::Paranoia
end

class ParanoiaTest < BaseTest
  class ModelClass
    include Mongoid::Document
    include Mongoid::Paranoia
    include Mongoid::Userstamps
  end

  test "deleted" do
    assert ModelClass < Mongoid::Userstamps::Deleted
  end
end
