require "rails_helper"

RSpec.describe "User Requests", type: :request do
    describe "POST /api/user/game_events" do
        let!(:user) { User.create(full_name: "Test User", email: "test@test.com", username: "test_user", password: "test123") }
        let!(:token) { JWT.encode({ user_id: user.id }, "test123") }

        it "returns created game_event" do
            game = Game.create!(name: "Math Game", category: "Math", url: "https://www.mathgame.com")

            post "/api/user/game_events", headers: { "Authorization": "Bearer #{token}" }, params: { game_event: { game_id: game.id }}

            json = JSON.parse(response.body)

            expect(json["game_event"]).to be_present
            expect(json["game_event"]["game_id"]).to eq(game.id)
            expect(json["game_event"]["user_id"]).to eq(user.id)
            expect(response.status).to eq(201)
        end
    end
end