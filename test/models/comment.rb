class Comment
  include Mongoid::Document
  include Mongoid::Userstamps::Updated
  include Mongoid::Userstamps::Deleted

  field :content

  userstamps_model.user_model = "Person"
end
