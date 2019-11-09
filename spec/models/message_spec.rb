require 'rails_helper'

RSpec.describe Message, type: :model do
  subject do
   described_class.new(
     attributes_for(:message)
   )
  end

  it 'validate non-presence of message' do
    subject.message = ''
    subject.valid?
    expect(subject.errors[:message]).to include("can't be blank")
  end
  it 'validate presence of name' do
    subject.message = 'message'
    subject.valid?
    expect(subject.errors[:message]).to_not include("can't be blank")
  end
end
