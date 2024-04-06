class Api::UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]
    rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

    def create 
        user = User.create!(user_params)

        render json: {
            user: UserSerializer.new(user), 
        }, status: :created
    end

    private

    def user_params 
        params.permit(:email, :username, :full_name, :password)
    end

    def handle_invalid_record(e)
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end
end
