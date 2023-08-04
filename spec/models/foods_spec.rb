require 'rails_helper'

RSpec.describe Food, type: :model do
  describe 'Food model' do
    @user = User.create(name: 'Ouail', email: 'Ouail@user.com', password: '123456')
    subject { Food.new(user_id: @user, name: 'Pasta', measurement_unit: 'K', price: 20) }
    before { subject.save }

    it 'the name is not blank' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'measurement_unit is not blank' do
      subject.measurement_unit = nil
      expect(subject).to_not be_valid
    end

    it 'price is not empty' do
      subject.price = nil
      expect(subject).to_not be_valid
    end
  end
end
