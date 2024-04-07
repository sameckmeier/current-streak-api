require "rails_helper"

RSpec.describe "Game Requests", type: :request do
    describe "GET /api/games" do
        let!(:user) { User.create(full_name: "Test User", email: "test@test.com", username: "test_user", password: "test123") }
        let!(:token) { JWT.encode({ user_id: user.id }, "test123") }

        it "returns correct number of game records" do
            Game::CATEGORIES.each do |category|
                Game.create!(name: "#{category} Game", category: category, url: "https://www.#{category.downcase}game.com")
            end

            get "/api/games", headers: { "Authorization": "Bearer #{token}" }

            json = JSON.parse(response.body)

            expect(json["games"].length()).to eq(Game::CATEGORIES.length())
            expect(response.status).to eq(200)
        end
    end
end