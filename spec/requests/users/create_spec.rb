require "rails_helper"

RSpec.describe "User Requests", type: :request do
    describe "POST /api/user" do
        it "returns created user" do
            post "/api/user", params: { user: { full_name: "Test User", email: "test@test.com", username: "test_user", password: "test123" }}

            json = JSON.parse(response.body)

            expect(json["user"]).to be_present
            expect(json["user"]["email"]).to eq("test@test.com")
            expect(response.status).to eq(201)
        end
    end
end