# README
* Ruby version
    * 3.3.0
    * Recommendation for Mac users: install chruby and ruby-install using homebrew to install this version of ruby (https://mac.install.guide/ruby/12)
* System dependencies
    * PostgreSQL 16.2
        * Recommendation for Mac users: install using homebrew (https://formulae.brew.sh/formula/postgresql@16). If you are not familiar with homebrew, I recommend reviewing this article to install PostgreSQL (https://www.moncefbelyamani.com/how-to-install-postgresql-on-a-mac-with-homebrew-and-lunchy/). Note, the article lists postgresql@14 rather than postgresql@16, so be sure to run all commands using postgresql@16.
    * Bundler 2.5.7
        * Run `gem install bundler` 
    * Rails 7.1.3.2
        * Run `gem install rails`
* Configuration
    * Add .env file to the project’s root directory
    * Add following vars to .env file:
        * DATABASE_USER=“your-db-user”
        * DATABASE_PASSWORD=“your-db-password”
        * JWT_SECRET_KEY=“your-secret-jwt-key“
     * Run `bundle install` to install all gems listed in the Gemfile
* Database setup
    * Run `rails db:setup` to create your dev and test DBs, loads the schema, and seeds the dev DB
* How to run the test suite
    * Run `rspec spec` to run all tests or `rspec spec/path/to/folder` to run specifics specs contained in a nested directory
* How to start the server
    * Run `rails s`
