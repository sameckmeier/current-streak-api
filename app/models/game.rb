class Game < ApplicationRecord
    CATEGORIES = ["Math", "Reading", "Speaking", "Writing"]
    
    validates :name, :url, :category, presence: true
    validates :category, inclusion: CATEGORIES

    has_many :game_events
end
