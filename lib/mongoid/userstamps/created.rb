module Mongoid
  module Userstamps
    module Created
      extend ActiveSupport::Concern

      included do
        unless included_modules.include?(Mongoid::Userstamps::Model)
          include Mongoid::Userstamps::Model
        end

        belongs_to userstamps_config.created_name, {
          class_name: userstamps_model.user_model,
          inverse_of: nil,
          optional: true,
        }

        set_callback :create, :before, :set_created_by
      end

      def set_created_by
        user = self.class.current_user
        return if !user || public_send(userstamps_config.created_name)
        public_send("#{userstamps_config.created_name}=", user)
      end
    end
  end
end
