require "rails_helper"

RSpec.describe "Session Requests", type: :request do
    describe "POST /api/sessions" do
        let!(:user) { User.create(full_name: "Test User", email: "test@test.com", username: "test_user", password: "test123") }
    
        describe "correct credentials" do
            it "returns auth token" do
                post "/api/sessions", params: { credentials: { email: "test@test.com", password: "test123" }}

                json = JSON.parse(response.body)

                expect(json["token"]).to be_present
                expect(response.status).to eq(200)
            end
        end

        describe "incorrect email" do
            it "returns error message" do
                post "/api/sessions", params: { credentials: { email: "test123@test.com", password: "test123" }}

                json = JSON.parse(response.body)

                expect(json["message"]).to eq("User doesn't exist")
                expect(response.status).to eq(401)
            end
        end

        describe "incorrect password" do
            it "returns error message" do
                post "/api/sessions", params: { credentials: { email: "test@test.com", password: "test456" }}

                json = JSON.parse(response.body)

                expect(json["message"]).to eq("Incorrect password")
                expect(response.status).to eq(401)
            end
        end
    end
end