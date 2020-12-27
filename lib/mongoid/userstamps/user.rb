module Mongoid
  module Userstamps
    module User
      extend ActiveSupport::Concern

      included do
        Mongoid::Userstamps::Config.add_user_class(self)
      end

      def current?
        id == self.class.current.try(:id)
      end

      class_methods do
        def current
          Mongoid::Userstamps::Config.current_user(self)
        end

        def current=(value)
          Mongoid::Userstamps::Config.set_current_user(self, value)
        end

        def sudo(user)
          old = current
          self.current = user
          yield
        ensure
          self.current = old
        end

        def userstamps_user
          @userstamps_user ||= Mongoid::Userstamps::Config::User.new(self)
        end
      end
    end
  end
end
