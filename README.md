# DBUtils

This gem provides support to ActiveRecord gem of Ruby on Rails working with namespaces.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'db_utils'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install db_utils

## Usage

In your ```config/database.yml``` add a namespace to configurations. Like that.

```yaml
some_namespace:
  test:
    database: some_namespace_test
    adapter:
    username:
    host: localhost

  development:
    database: some_namespace_development
    adapter:
    username:
    host: localhost

  staging:
    database: some_namespace_staging
    adapter:
    username:
    host:

  production:
    database: some_namespace_production
    adapter:
    username:
    host:
```

Includes ```DBUtils::Connector``` in your model that are encapsulated in a module to automatically connect to database.

**Obs.**: The modules should have same name that the namespace defined in ```database.yml```

### Generating database

Run
```shell
$ rake db:create db:migrate MIGRATIONS_NAMESPACE=defined_namespace
```

or

```shell
$ rake db:create db:migrate MIGRATIONS_NAMESPACES=defined_namespace1,defined_namespace2
```

### When installation engine migrations

After Run

```shell
$ rake <some engine>:install:migrations
```
The migrations will go to a folder with same name of migration. That folder can be renamed, but the namespace defined in ```database.yml``` should have the same name of the folder.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rplaurindo/db_utils.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
