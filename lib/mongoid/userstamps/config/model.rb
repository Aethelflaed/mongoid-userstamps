module Mongoid
  module Userstamps
    module Config
      class Model
        def initialize(model)
          @model = model
          @user_model = nil
        end

        def config
          Mongoid::Userstamps::Config
        end

        def user_model
          @user_model || config.user_classes.first.to_s
        end

        def user_model=(value)
          @user_model = value.to_s if value
          set_user_model!
        end

        def set_user_model!
          if Mongoid::VERSION.to_f < 7.0
            %i[created_name updated_name deleted_name].each do |attr|
              @model.relations[config.send(attr).to_s].try(:[]=, :class_name, user_model)
            end
          else
            %i[created_name updated_name deleted_name].each do |attr|
              if @model.relations[config.send(attr).to_s]
                @model.relations[config.send(attr).to_s].instance_variable_set :@class_name, user_model
                @model.relations[config.send(attr).to_s].options[:class_name] = user_model
              end
            end
          end
        end
      end
    end
  end
end
