require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:project_activities).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:status) }
  end

  describe 'constants' do
    it 'defines STATUSES with the correct values' do
      expect(Project::STATUSES).to eq(['open', 'in_progress', 'closed'])
    end
  end
end
