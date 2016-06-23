# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'db_utils/version'

Gem::Specification.new do |spec|
  spec.name           = "db_utils-rails"
  spec.version        = DBUtils::Rails::VERSION
  spec.authors        = ["Rafael Laurindo"]
  spec.email          = ["rafaelplaurindo@gmail.com"]
  spec.homepage       = "https://rubygems.org/gems/db_utils"
  spec.summary        = %q{Summary of DBUtils}
  spec.description    = %q{This gem provides support to ActiveRecord gem of Ruby on Rails working with namespaces}
  spec.license        = "MIT"

  spec.test_files     = Dir["test/**/*"]

  spec.files          = Dir["{bin,config,lib,vendor}/**/*", "CODE_OF_CONDUCT.md", "MIT-LICENSE", "README.md", "Rakefile"]
  spec.require_paths  = %w{bin config lib vendor}
end
