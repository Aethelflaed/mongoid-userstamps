class Archive
  include Mongoid::Document
  include Mongoid::Userstamps::Deleted

  field :content
end
