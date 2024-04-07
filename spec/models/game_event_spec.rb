require "rails_helper"

RSpec.describe "GameEvent Model", type: :request do
    let!(:user) { User.create(full_name: "Test User", email: "test@test.com", username: "test_user", password: "test123") }

    describe "games_played_counts" do
        it "returns the number of games a user played for each game category" do
            Game::CATEGORIES.each do |category|
                game = Game.create!(name: "#{category} Game", category: category, url: "https://www.#{category.downcase}game.com")
                GameEvent.create!(user_id: user.id, game_id: game.id, event_type: "COMPLETED")
            end
            
            games_played_counts = GameEvent.games_played_counts(user.id)

            Game::CATEGORIES.each do |category|
                expect(games_played_counts[category]).to eq(1)
            end
        end
    end

    describe "total_games_played" do
        it "returns total number of games a user played" do
            Game::CATEGORIES.each do |category|
                game = Game.create!(name: "#{category} Game", category: category, url: "https://www.#{category.downcase}game.com")
                GameEvent.create!(user_id: user.id, game_id: game.id, event_type: "COMPLETED")
            end

            expect(GameEvent.total_games_played(user.id)).to eq(Game::CATEGORIES.length())
        end
    end
end