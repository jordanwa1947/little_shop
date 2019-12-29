# Little Shop

Little Shop is an online shopping platform that allows users to find merchants and place orders on items those merchants have posted.

Merchants may manage and fulfill orders through the little shop website. SQL queries also give merchants statistics on their sales and performance.

Admin name-spacing gives admin users authorization, when authenticated, to have sole access to all facets of the website. For example a merchant may be downgraded to a registered user or a registered user may be upgraded as well. Admins may also edit any user's information and their posted products as well.

## Versions

Ruby version: ``ruby '2.4.5'``

Rails version: ``'rails', '~> 5.1.7'`` (without Mini-test, Turbolinks & Spring)

Database: Postgresql

Chrome for Selenium testing with [Webdriver](https://github.com/titusfortner/webdrivers).

## Install

1 - Setup Environment: Upon download, run ``bundle install``.

2 - Setup DB: ``bundle exec rake db:{drop,create,migrate,seed}``

## Gems

##### Production:
-``gem 'rails', '~> 5.1.6'``
-``gem 'pg', '>= 0.18', '< 2.0'``
-``gem 'puma', '~> 3.7'``
-``gem "react_on_rails", "11.0.0"``
-``gem "webpacker", "~> 3"``

##### Testing & Development:
-``gem 'pry'``
-``gem 'simplecov'``
-``gem 'rspec-rails'``
-``gem 'database_cleaner'``
-``gem 'capybara'``
-``gem 'selenium-webdriver'``
-``gem 'webdrivers', '~> 4.0'``
-``gem 'launchy'``
-``gem 'shoulda-matchers', '~> 3.1'``

## Testing
MiniTest has been excluded from this app, opting for RSpec instead.

Run RSpec via ``bundle exec rspec``
