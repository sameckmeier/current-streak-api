class GameSerializer < ActiveModel::Serializer
  attributes :id, :name, :category, :url
end
