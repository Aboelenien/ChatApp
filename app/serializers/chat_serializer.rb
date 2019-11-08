class ChatSerializer < ActiveModel::Serializer
  attributes :number, :messages_count
  belongs_to :application
  has_many :messages
end
