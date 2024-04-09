class User < ApplicationRecord
    has_secure_password
    
    validates :email, :username, uniqueness: true
    validates :email, :username, :full_name, presence: true

    def stats
        return {} if !self.id

        total_games_played = GameEvent.total_games_played(self.id)
        games_played_counts = GameEvent.games_played_counts(self.id)
        current_streak_in_days = GameEvent.current_streak_in_days(self.id)

        return {
            total_games_played: total_games_played,
            total_math_games_played: games_played_counts["Math"] || 0,
            total_reading_games_played: games_played_counts["Reading"] || 0,
            total_speaking_games_played: games_played_counts["Speaking"] || 0,
            total_writing_games_played: games_played_counts["Writing"] || 0,
            current_streak_in_days: current_streak_in_days
        }
    end
end
