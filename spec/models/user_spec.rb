require "rails_helper"

RSpec.describe "User Model", type: :model do
    let!(:user) { User.create(full_name: "Test User", email: "test@test.com", username: "test_user", password: "test123") }

    describe "stats" do
        it "returns user's game stats" do
            Game::CATEGORIES.each do |category|
                game = Game.create!(name: "#{category} Game", category: category, url: "https://www.#{category.downcase}game.com")
                GameEvent.create!(user_id: user.id, game_id: game.id, event_type: "COMPLETED")
            end
            
            stats = user.stats

            expect(stats[:total_games_played]).to eq(4)
            expect(stats[:total_math_games_played]).to eq(1)
            expect(stats[:total_reading_games_played]).to eq(1)
            expect(stats[:total_speaking_games_played]).to eq(1)
            expect(stats[:total_writing_games_played]).to eq(1)
            expect(stats[:current_streak_in_days]).to eq(1)
        end
    end
end