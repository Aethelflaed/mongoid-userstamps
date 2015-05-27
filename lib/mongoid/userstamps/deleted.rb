# -*- encoding : utf-8 -*-

module Mongoid
  module Userstamps
    module Deleted
      extend ActiveSupport::Concern

      included do
        if !self.included_modules.include?(Mongoid::Userstamps::Model)
          include Mongoid::Userstamps::Model
        end

        belongs_to userstamps_config.deleted_name, {
          class_name: userstamps_model.user_model,
          inverse_of: nil
        }

        set_callback :destroy, :before, :set_deleted_by
      end

      def set_deleted_by
        user = self.class.current_user
        return if !user || self.public_send("#{userstamps_config.deleted_name}_id_changed?")
        self.public_send("#{userstamps_config.deleted_name}=", user)
      end
    end
  end
end

