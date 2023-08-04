require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has many recipes' do
    association = described_class.reflect_on_association(:recipes)
    expect(association.macro).to eq :has_many
  end

  it 'Not valid without a name' do
    user = User.new(name: nil)
    expect(user).to_not be_valid
  end
end
