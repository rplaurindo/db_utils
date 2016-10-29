# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'migreatest/rails/version'

Gem::Specification.new do |spec|
  spec.name           = "migreatest-rails"
  spec.version        = Migreatest::Rails::VERSION
  spec.authors        = ["Rafael Laurindo"]
  spec.email          = ["rafaelplaurindo@gmail.com"]
  spec.homepage       = "https://rubygems.org/gems/migreatest-rails"
  spec.summary        = %q{Summary of Migreatest}
  spec.description    = %q{This gem provides support for ActiveRecord gem of Ruby on Rails to work with namespaces}
  spec.license        = "MIT"

  spec.test_files     = Dir["test/**/*"]

  spec.files          = Dir["{bin,config,lib,vendor}/**/*", "CODE_OF_CONDUCT.md", "MIT-LICENSE", "README.md", "Rakefile"]
  spec.require_paths  = %w{bin config lib vendor}

  spec.add_dependency 'rails', '~> 4'
end
