require 'rails_helper'

RSpec.describe Hole, type: :model do
  subject { create(:hole) }

  describe 'validation' do
    describe 'name' do
      it { is_expected.to validate_presence_of(:name) }
    end

    describe 'subdomain' do
      it { is_expected.to validate_presence_of(:subdomain) }
      it { is_expected.to validate_exclusion_of(:subdomain).in_array(['www', '404']) }
      it { is_expected.to validate_length_of(:subdomain).is_at_least(3) }
      it { is_expected.to validate_length_of(:subdomain).is_at_most(30) }
      it { is_expected.to allow_value('abc-def-123').for(:subdomain) }
      it { is_expected.to_not allow_value('With Non-Alpha Chars!').for(:subdomain) }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:grabs) }
    it { is_expected.to have_many(:hole_memberships) }
    it { is_expected.to have_many(:users).through(:hole_memberships) }
  end

  describe '#owner' do
    before { subject.hole_memberships.take.update(owner: true) }

    it 'returns the owner of the hole' do
      expect(subject.owner).to be_a(User)
    end
  end
end
