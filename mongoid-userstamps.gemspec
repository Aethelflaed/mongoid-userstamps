$:.push File.expand_path("../lib", __FILE__)

require "mongoid/userstamps/version"

Gem::Specification.new do |s|
  s.name = "mongoid-userstamps"
  s.version = Mongoid::Userstamps::VERSION
  s.authors = ["Geoffroy Planquart", "Thomas Boerger", "Johnny Shields", "Bharat Gupta"]
  s.homepage = "https://github.com/tbpro/mongoid_userstamp"
  s.license = "MIT"
  s.summary = "Userstamps for Mongoid"
  s.description = "Userstamps for creator and updater fields using Mongoid"
  s.email = ["geoffroy@planquart.fr", "tboerger@tbpro.de"]

  s.files = `git ls-files`.split($/)
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.post_install_message = File.read("UPGRADING") if File.exist?("UPGRADING")

  s.add_dependency "mongoid", ">= 5.0.0", "< 7.2.0"
  s.add_dependency "activesupport", ">= 4.2.0", "< 6.1.0"
end
