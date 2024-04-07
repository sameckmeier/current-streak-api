class User < ApplicationRecord
    has_secure_password
    
    validates :email, :username, uniqueness: true
    validates :email, :username, :full_name, presence: true

    def stats
        return {} if !self.id

        total_games_played = GameEvent.total_games_played(self.id)
        games_played_counts = GameEvent.games_played_counts(self.id)

        return {
            total_games_played: total_games_played,
            total_math_games_played: games_played_counts["Math"],
            total_reading_games_played: games_played_counts["Reading"],
            total_speaking_games_played: games_played_counts["Speaking"],
            total_writing_games_played: games_played_counts["Writing"]
        }
    end
end
