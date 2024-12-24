# README

- use anthropic API to generate recipe based on given ingredients

## stack:
  - ruby-3.3.6
  - rails 7.2.2
  - grape
  - sidekiq
  - config
  - rspec
  - - factory_bot
  - - vrc
  - - rswag
  
1. `cp config/settings/test.yml config/settings/test.local.yml`
2. `cp config/settings.yml config/settings.local.yml`
3. update test.local.yml and settings.local.yml with your secrets
4. `rake db:create db:migrate`
 
## web

after rails s
- basic GUI is available at `localhost:3000`
- api docs are available at `localhost:3000/swagger`

## ideas to improvement

- add pagination, search and validation to ingredients
- add auth token to rails API