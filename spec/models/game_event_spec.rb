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

    describe "current_streak" do
        let!(:game) { Game.create!(name: "Math Game", category: "Math", url: "https://www.mathgame.com") }

        describe "current streak includes today" do
            describe "3 day streak" do
                it "returns correct streak count" do
                    GameEvent.create!(user_id: user.id, game_id: game.id, event_type: "COMPLETED", occured_at: DateTime.now)
                    GameEvent.create!(user_id: user.id, game_id: game.id, event_type: "COMPLETED", occured_at: 1.days.ago)
                    GameEvent.create!(user_id: user.id, game_id: game.id, event_type: "COMPLETED", occured_at: 2.days.ago)

                    expect(GameEvent.current_streak(user.id)).to eq(3)
                end
            end

            describe "2 day streak with interuption" do
                it "returns correct streak count" do
                    GameEvent.create!(user_id: user.id, game_id: game.id, event_type: "COMPLETED", occured_at: DateTime.now)
                    GameEvent.create!(user_id: user.id, game_id: game.id, event_type: "COMPLETED", occured_at: 1.days.ago)
                    GameEvent.create!(user_id: user.id, game_id: game.id, event_type: "COMPLETED", occured_at: 3.days.ago)

                    expect(GameEvent.current_streak(user.id)).to eq(2)
                end
            end

            describe "1 day streak" do
                it "returns correct streak count" do
                    GameEvent.create!(user_id: user.id, game_id: game.id, event_type: "COMPLETED", occured_at: DateTime.now)

                    expect(GameEvent.current_streak(user.id)).to eq(1)
                end
            end

            describe "1 day streak with interuption" do
                it "returns correct streak count" do
                    GameEvent.create!(user_id: user.id, game_id: game.id, event_type: "COMPLETED", occured_at: DateTime.now)
                    GameEvent.create!(user_id: user.id, game_id: game.id, event_type: "COMPLETED", occured_at: 2.days.ago)

                    expect(GameEvent.current_streak(user.id)).to eq(1)
                end
            end
        end

        describe "current streak does not include today" do
            describe "3 day streak" do
                it "returns correct streak count" do
                    GameEvent.create!(user_id: user.id, game_id: game.id, event_type: "COMPLETED", occured_at: 1.days.ago)
                    GameEvent.create!(user_id: user.id, game_id: game.id, event_type: "COMPLETED", occured_at: 2.days.ago)
                    GameEvent.create!(user_id: user.id, game_id: game.id, event_type: "COMPLETED", occured_at: 3.days.ago)

                    expect(GameEvent.current_streak(user.id)).to eq(3)
                end
            end

            describe "2 day streak with interuption" do
                it "returns correct streak count" do
                    GameEvent.create!(user_id: user.id, game_id: game.id, event_type: "COMPLETED", occured_at: 1.days.ago)
                    GameEvent.create!(user_id: user.id, game_id: game.id, event_type: "COMPLETED", occured_at: 2.days.ago)
                    GameEvent.create!(user_id: user.id, game_id: game.id, event_type: "COMPLETED", occured_at: 4.days.ago)

                    expect(GameEvent.current_streak(user.id)).to eq(2)
                end
            end

            describe "1 day streak" do
                it "returns correct streak count" do
                    GameEvent.create!(user_id: user.id, game_id: game.id, event_type: "COMPLETED", occured_at: 1.days.ago)

                    expect(GameEvent.current_streak(user.id)).to eq(1)
                end
            end
        end

        describe "no current streak" do
            it "returns correct streak count" do
                GameEvent.create!(user_id: user.id, game_id: game.id, event_type: "COMPLETED", occured_at: 2.days.ago)
                GameEvent.create!(user_id: user.id, game_id: game.id, event_type: "COMPLETED", occured_at: 3.days.ago)

                expect(GameEvent.current_streak(user.id)).to eq(0)
            end
        end
    end
end