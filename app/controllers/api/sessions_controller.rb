class Api::SessionsController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def create 
        user = User.find_by(email: credential_params[:email])

        if !user
            render json: { message: "User doesn't exist" }, status: :unauthorized
        end

        if user.authenticate(credential_params[:password])
            token = encode_token(user_id: user.id)
            render json: { token: token }, status: :ok
        else
            render json: {message: "Incorrect password"}, status: :unauthorized
        end
    end

    private 

    def credential_params 
        params.require(:credentials).permit(:email, :password)
    end
end
