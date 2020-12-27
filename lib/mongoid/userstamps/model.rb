module Mongoid
  module Userstamps
    module Model
      extend ActiveSupport::Concern

      included do
        Mongoid::Userstamps::Config.add_model_class(self)
      end

      def userstamps_config
        self.class.userstamps_config
      end

      class_methods do
        def userstamps_model
          @userstamps_model ||= Mongoid::Userstamps::Config::Model.new(self)
        end

        def current_user
          userstamps_config.current_user(userstamps_model.user_model)
        end

        def userstamps_config
          Mongoid::Userstamps::Config
        end
      end
    end
  end
end
