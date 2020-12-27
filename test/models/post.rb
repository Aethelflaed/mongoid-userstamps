class Post
  include Mongoid::Document
  include Mongoid::Userstamps

  userstamps_model.user_model = "User"

  field :title
end
