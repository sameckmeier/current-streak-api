require "rails_helper"

RSpec.describe "Session Requests", type: :request do
    describe "POST /api/sessions" do
        let!(:user) { User.create(full_name: "Test User", email: "test@test.com", username: "test_user", password: "test123") }

        it "returns auth token" do
            post "/api/sessions", params: { email: "test@test.com", password: "test123" }

            json = JSON.parse(response.body)

            expect(json["token"]).to be_present
            expect(response.status).to eq(200)
        end
    end
end