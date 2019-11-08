class Application < ApplicationRecord
  before_create :set_access_token
  has_many :chats, dependent: :destroy

  private

  def set_access_token
    self.token = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.hex(10)
      break token unless Application.where(token: token).exists?
    end
  end

  def chats_count
    self.chats_count = self.chats.count
  end
end
