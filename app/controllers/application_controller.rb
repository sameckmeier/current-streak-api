class ApplicationController < ActionController::API
    before_action :authorized

    def encode_token(payload)
        payload[:exp] = (Time.now + 15.minutes).to_i
        return JWT.encode(payload, ENV["JWT_SECRET_KEY"])
    end

    def decoded_token
        header = request.headers["Authorization"]
        if header
            token = header.split(" ")[1]
            begin
                return JWT.decode(token, ENV["JWT_SECRET_KEY"], true, algorithm: "HS256")
            rescue JWT::DecodeError
                return nil
            end
        end
    end

    def current_user 
        if decoded_token
            return @user if @user

            user_id = decoded_token[0]["user_id"]
            @user = User.find_by(id: user_id)

            return @user
        end

        return nil
    end

    def authorized
        if !current_user
            render json: { message: "Please log in" }, status: :unauthorized
        end
    end
end
