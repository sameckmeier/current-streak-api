class Api::UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]
    rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

    def get
        render json: {
            user: UserSerializer.new(current_user), 
        }, status: :ok
    end

    def create
        user = User.create!(user_params)

        render json: {
            user: UserSerializer.new(user), 
        }, status: :created
    end

    def create_game_event
        game_event = GameEvent.create!(game_event_params.merge({ event_type: "COMPLETED", user_id: current_user.id }))

        render json: {
            game_event: GameEventSerializer.new(game_event), 
        }, status: :created
    end

    private

    def user_params
        params.require(:user).permit(:email, :username, :full_name, :password)
    end

    def game_event_params
        params.require(:game_event).permit(:game_id)
    end

    def handle_invalid_record(e)
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end
end
