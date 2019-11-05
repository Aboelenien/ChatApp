class ChatSerializer < ActiveModel::Serializer
  attributes :number
  belongs_to :application
end
