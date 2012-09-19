# -*- encoding : utf-8 -*-
module Mongoid
  module Userstamp
    module Version
      MAJOR = 0
      MINOR = 1
      PATCH = 4
      BUILD = nil

      STRING = [MAJOR, MINOR, PATCH, BUILD].compact.join('.')
    end
  end
end
