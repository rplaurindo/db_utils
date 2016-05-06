# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'db_utils/version'

Gem::Specification.new do |spec|
  spec.name             = "db_utils"
  spec.version          = DBUtils::VERSION
  spec.authors          = ["Rafael Laurindo"]
  spec.email            = ["rafaelplaurindo@gmail.com"]
  spec.homepage         = "https://rubygems.org/gems/db_utils"
  spec.summary          = %q{Summary of DBUtils}
  spec.description      = %q{Provides support to namespace in "rake tasks" of Ruby on Rails}
  spec.license          = "MIT"

  spec.files = Dir["{lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  spec.test_files = Dir["test/**/*"]
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", "~> 4.2"

end
