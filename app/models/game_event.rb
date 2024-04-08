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

        # fetch all game events sorted by occured_at in DESC order
        game_events = self.where(user_id: user_id, event_type: "COMPLETED").order(occured_at: :desc)
        
        # set variable streak to an empty array where each element can be true/nil
        # and the element's index represents days ago from today, ie, index 6 would be 6 days ago from today
        streak = []
        today = DateTime.now.to_date
        
        # iterate over game events, calculate streak index by today - game_event#occured_at,
        # and set that index to true to represent that a game was completed on that day in the past or today
        game_events.each do |game_event|
            i = (today - game_event.occured_at.to_date).to_i
            streak[i] = true
        end

        # starting at index 1, count current continous streak and
        # break when we encounter the first nil element in streak
        i = 1
        while i < streak.length()
            if streak[i]
                res += 1
            else
                break
            end

            i += 1
        end

        # check whether user completed a game today and if so increment res by 1
        if streak[0]
            res += 1
        end

        return res
    end

    private

    def set_occured_at_to_now
        if !self.occured_at
            self.occured_at = Time.now
        end
    end
end
