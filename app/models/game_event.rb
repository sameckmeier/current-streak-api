class GameEvent < ApplicationRecord
    EVENT_TYPES = ["COMPLETED"]

    before_validation :set_occured_at_to_now, on: :create

    validates :occured_at, :event_type, presence: true
    validates :event_type, inclusion: EVENT_TYPES

    belongs_to :user
    belongs_to :game

    private

    def set_occured_at_to_now
        if !self.occured_at
            self.occured_at = Time.now
        end
    end
end
