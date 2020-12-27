class User
  include Mongoid::Document
  include Mongoid::Userstamps::User

  field :name

  userstamps_user.reader = :current_admin
end
