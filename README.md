# README
* Ruby version
    * 3.3.0
* System dependencies
    * PostgreSQL v14
* Configuration
    * Add .env file to the project’s root directory
    * Add following vars to .env file:
        * DATABASE_USER=“your-db-user”
        * DATABASE_PASSWORD=“your-db-password”
        * JWT_SECRET_KEY=“your-secret-jwt-key“
* Database setup
    * Run `rails db:setup` to create your dev and test DBs, loads the schema, and seeds the dev DB
* How to run the test suite
    * Run `rspec spec` to run all tests or `rspec spec/path/to/folder` to run specifics specs contained in a nested directory
* How to start the server
    * Run `rails s`
