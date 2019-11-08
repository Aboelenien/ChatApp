class MessageSerializer < ActiveModel::Serializer
  attributes :number, :message
  belongs_to :chat
end
