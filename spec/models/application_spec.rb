require 'rails_helper'

RSpec.describe Application, type: :model do
  subject do
   described_class.new(
     attributes_for(:application)
   )
  end

  it 'validate non-presence of name' do
    subject.name = ''
    subject.valid?
    expect(subject.errors[:name]).to include("can't be blank")
  end
  it 'validate presence of name' do
    subject.name = 'Application'
    subject.valid?
    expect(subject.errors[:name]).to_not include("can't be blank")
  end

end
