class Chat < ApplicationRecord
  belongs_to :application
  has_many :messages, dependent: :destroy

  def messages_count
    self.messages_count = self.messages.count
  end
end
