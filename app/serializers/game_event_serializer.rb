class GameEventSerializer < ActiveModel::Serializer
  attributes :id, :event_type, :occured_at, :game_id, :user_id
end
