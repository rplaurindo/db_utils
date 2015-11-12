# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'databases_migrations_manager/version'

Gem::Specification.new do |spec|
  spec.name             = "databases_migrations_manager"
  spec.version          = DatabasesMigrationsManager::VERSION
  spec.authors          = ["Home Labs"]
  spec.email            = ["home-labs@outlook.com"]
  spec.homepage         = "https://rubygems.org/gems/databases_migrations_manager"
  spec.summary          = %q{Summary of DatabasesMigrationsManager}
  spec.description      = %q{Description of DatabasesMigrationsManager}
  spec.license          = "MIT"

  spec.files = Dir["{lib}/**/*", "MIT-LICENSE", "Rakefile"]

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"

end
