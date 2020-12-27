require "mongoid/userstamps/config/model"
require "mongoid/userstamps/config/user"

module Mongoid
  module Userstamps
    module Config
      class << self
        DEFAULT_CREATED_NAME = :created_by
        DEFAULT_UPDATED_NAME = :updated_by
        DEFAULT_DELETED_NAME = :deleted_by

        def user_classes
          @user_classes ||= []
        end

        def add_user_class(klass)
          user_classes << klass
          model_classes.each do |model|
            model.userstamps_model.set_user_model!
          end
        end

        def model_classes
          @model_classes ||= []
        end

        def add_model_class(klass)
          model_classes << klass
        end

        attr_writer :created_name

        def created_name
          @created_name ||= DEFAULT_CREATED_NAME
        end

        attr_writer :updated_name

        def updated_name
          @updated_name ||= DEFAULT_UPDATED_NAME
        end

        attr_writer :deleted_name

        def deleted_name
          @deleted_name ||= DEFAULT_DELETED_NAME
        end

        def current_user(user_class)
          store(user_class)
        end

        def set_current_user(user_class, value)
          store(user_class, value)
        end

        def store(model, value = false)
          return unless model
          key = "mongoid-userstamps/#{model.to_s.underscore}".to_sym
          store = defined?(RequestStore) ? RequestStore.store : Thread.current
          if value == false
            store[key]
          else
            store[key] = value
          end
        end

        def reset
          @created_name = DEFAULT_CREATED_NAME
          @updated_name = DEFAULT_UPDATED_NAME
          @deleted_name = DEFAULT_DELETED_NAME
        end
      end
    end
  end
end
