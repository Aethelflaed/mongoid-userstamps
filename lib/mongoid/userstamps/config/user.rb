module Mongoid
  module Userstamps
    module Config
      class User
        attr_accessor :reader

        def initialize(model)
          @reader = "current_#{model.name.underscore}".to_sym
        end
      end
    end
  end
end
