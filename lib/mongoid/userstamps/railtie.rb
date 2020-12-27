module Mongoid
  module Userstamps
    class Railtie < Rails::Railtie
      # Set current_user from controller reader method
      ActiveSupport.on_load :action_controller do
        before_action do |c|
          Mongoid::Userstamps::Config.user_classes.each do |user_class|
            user_class.current = c.public_send(user_class.userstamps_user.reader)
          rescue
          end
        end
      end
    end
  end
end
