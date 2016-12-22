# ActiveAdminVersioning

Good for auditing or versioning for [Active Admin](https://github.com/activeadmin/activeadmin) (using [PaperTrail](https://github.com/airblade/paper_trail))

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_admin_versioning'
```

And then execute:

    $ bundle

## Configuration

In some cases you may need to display some extra or formatted text in whodunnit.
For example whodunit is an ID of your user. And you want to display not just a number, but his E-mail.

Create configuration 'config/initializers/active_admin_versionings.rb'

```ruby
ActiveAdminVersioning.configure do |config|
  config.whodunnit_attribute_name = :display_whodunnit
end
```


In you model:

```ruby
has_paper_trail class_name: 'MyPaperTrail'
```

```ruby
class MyPaperTrail < PaperTrail::Version
  def display_whodunnit
    AdminUser.find(whodunnit).email
  end
end
```

This alternative "whodunnit" will only be visible in "Version" sidebar and "Version" page.


## Recipe for Rails 5

1. Add necessary gems to `Gemfile` and `bundle`:

  ```ruby
  gem 'activeadmin', github: 'activeadmin'
  gem 'devise'
  gem 'inherited_resources', github: 'activeadmin/inherited_resources'
  gem 'paper_trail', '~> 5.2.0'
  gem 'active_admin_versioning'
  ```

2. Install Active Admin and Paper Trail:

  ```sh
  $ bin/rails generate active_admin:install
  $ bin/rails generate paper_trail:install
  $ bin/rails db:create db:migrate db:seed
  ```

3. Add module of Paper Trail to `AdminUser`:

  ```ruby
  class AdminUser < ApplicationRecord
    has_paper_trail
  end
  ```

4. Run server `bin/rails server` and open [localhost:3000](http://localhost:3000/admin)

![](https://cloud.githubusercontent.com/assets/15371677/20568714/b163df5e-b1e0-11e6-910d-198ece1e80f5.png)

![](https://cloud.githubusercontent.com/assets/15371677/20568746/cff3ccfe-b1e0-11e6-96b8-00d8bc241a4e.png)

## License

[MIT License](http://opensource.org/licenses/MIT)
