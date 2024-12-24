# README

uses anthropic API to generate recipe based on given ingredients

## stack

  - ruby-3.3.6
  - rails 7.2.2
  - grape
  - sidekiq
  - config
  - rspec with factory_bot, vcr, rswag, faker

## configuration
  
1. `cp config/settings/test.yml config/settings/test.local.yml`
2. `cp config/settings.yml config/settings.local.yml`
3. update test.local.yml and settings.local.yml with your secrets
4. `bundle`
5. `rake db:create db:migrate`
6. make sure that `redis-server` is running locally
7. `bundle exec sidekiq`
 
## web

after `rails s`
- basic GUI is available at `localhost:3000`
- api docs are available at `localhost:3000/swagger`

## ideas to improvement

- add pagination, search and validation to ingredients
- add auth token to rails API
