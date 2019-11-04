class Application < ApplicationRecord
  before_create :set_access_token

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
end
