# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'db_utils/version'

Gem::Specification.new do |spec|
  spec.name             = "db_utils-rails"
  spec.version          = DBUtils::VERSION
  spec.authors          = ["Home Labs"]
  spec.email            = ["home-labs@outlook.com"]
  spec.homepage         = "https://rubygems.org/gems/db_utils"
  spec.summary          = %q{Summary of DBUtils}
  spec.description      = %q{Description of DBUtils}
  spec.license          = "MIT"

  spec.files = Dir["{lib}/**/*", "MIT-LICENSE", "Rakefile"]

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "rails", "~> 4.2"
  spec.add_dependency 'rdoc', '~> 4.2'
  spec.add_dependency 'byebug', '~> 8.2'

end
