class GameEvent < ApplicationRecord
    EVENT_TYPES = ["COMPLETED"]

    before_validation :set_occured_at_to_now, on: :create

    validates :occured_at, :event_type, presence: true
    validates :event_type, inclusion: EVENT_TYPES

    belongs_to :user
    belongs_to :game

    scope :games_played_counts, -> (user_id) { joins(:game).where(user_id: user_id, event_type: "COMPLETED").group(:category).count }
    scope :total_games_played, -> (user_id) { where(user_id: user_id, event_type: "COMPLETED").count }

    def self.current_streak_in_days(user_id)
        res = 0

        # Fetch all game events sorted by occured_at in DESC order.
        game_events = self.where(user_id: user_id, event_type: "COMPLETED").order(occured_at: :desc)
        
        # Set variable streak to an empty array where each element can be true/nil
        # and the element's index represents days ago from today, ie, index 0 would be today
        # and index 1 would be 1 day ago from today.
        streak = []
        today = Time.now.utc.to_date

        # Iterate over game events, calculate streak index by today - game_event#occured_at,
        # and set that index to true to represent that a game was completed on that day in the past or today.
        game_events.each do |game_event|
            i = (today - game_event.occured_at.to_date).to_i
            streak[i] = true
        end

        # Check whether user completed a game today and if so increment res by 1.
        res += 1 if streak[0]

        # Starting at index 1, count current continous streak and
        # break when we encounter the first nil element in the streak array
        # since a nil element signifies that the user did not complete a game that day.
        # This loop starts at index 1 instead of index 0 since we have already checked index 0
        # and to prevent returning a current streak of 0 because users can still have
        # a continous streak even if they haven't played today. 
        i = 1
        while i < streak.length()
            if streak[i]
                res += 1
            else
                break
            end

            i += 1
        end

        return res
    end

    private

    def set_occured_at_to_now
        self.occured_at = Time.now.utc if !self.occured_at
    end
end
