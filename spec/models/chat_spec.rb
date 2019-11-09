require 'rails_helper'

RSpec.describe Chat, type: :model do
  subject do
   described_class.new(
     attributes_for(:chat)
   )
  end
end
