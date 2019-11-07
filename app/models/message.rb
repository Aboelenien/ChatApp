class Message < ApplicationRecord
  belongs_to :chat,  dependent: :destroy
end
