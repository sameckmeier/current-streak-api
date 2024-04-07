class GameEvent < ApplicationRecord
    EVENT_TYPES = ["COMPLETED"]

    before_validation :set_occured_at_to_now, on: :create

    validates :occured_at, :event_type, presence: true
    validates :event_type, inclusion: EVENT_TYPES

    belongs_to :user
    belongs_to :game

    scope :games_played_counts, -> (user_id) { joins(:game).where(user_id: user_id, event_type: "COMPLETED").group(:category).count }
    scope :total_games_played, -> (user_id) { where(user_id: user_id, event_type: "COMPLETED").count }

    private

    def set_occured_at_to_now
        if !self.occured_at
            self.occured_at = Time.now
        end
    end
end
