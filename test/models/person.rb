class Person
  include Mongoid::Document
  include Mongoid::Userstamps::User

  field :name
end
