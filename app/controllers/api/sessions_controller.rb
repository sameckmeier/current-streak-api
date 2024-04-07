class Api::SessionsController < ApplicationController
    skip_before_action :authorized, only: [:create]
    rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

    def create 
        user = User.find_by!(email: credential_params[:email])
        if user.authenticate(credential_params[:password])
            token = encode_token(user_id: user.id)
            render json: { token: token }, status: :accepted
        else
            render json: {message: "Incorrect password"}, status: :unauthorized
        end
    end

    private 

    def credential_params 
        params.permit(:email, :password)
    end

    def handle_record_not_found(e)
        render json: { message: "User doesn't exist" }, status: :unauthorized
    end
end
