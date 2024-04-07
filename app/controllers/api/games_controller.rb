class Api::GamesController < ApplicationController
    def index
        games = Game.all()
        render json: games, each_serilaizer: GameSerializer, root: "games", adapter: :json, status: :ok
    end
end
