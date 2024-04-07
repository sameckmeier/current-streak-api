class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :username, :email, :stats
end
