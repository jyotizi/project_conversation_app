require 'rails_helper'

RSpec.describe ProjectActivity, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:project) }
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    subject { build(:project_activity) }

    it { is_expected.to validate_presence_of(:activity_type) }
  end

  describe "custom validations" do
    context "when activity_type is 'status_change'" do
      context "and old_status is blank" do
        subject { build(:project_activity, activity_type: 'status_change', old_status: nil, new_status: 'active') }
        it "is not valid and adds an error for old_status" do
          expect(subject).not_to be_valid
          expect(subject.errors[:old_status]).to include("can't be blank")
        end
      end

      context "and new_status is blank" do
        subject { build(:project_activity, activity_type: 'status_change', old_status: 'inactive', new_status: nil) }
        it "is not valid and adds an error for new_status" do
          expect(subject).not_to be_valid
          expect(subject.errors[:new_status]).to include("can't be blank")
        end
      end

      context "and both statuses are blank" do
        subject { build(:project_activity, activity_type: 'status_change', old_status: nil, new_status: nil) }
        it "is not valid and adds errors for both old_status and new_status" do
          expect(subject).not_to be_valid
          expect(subject.errors[:old_status]).to include("can't be blank")
          expect(subject.errors[:new_status]).to include("can't be blank")
        end
      end

      context "and both statuses are present" do
        subject { build(:project_activity, activity_type: 'status_change', old_status: 'inactive', new_status: 'active') }
        it "is valid" do
          expect(subject).to be_valid
        end
      end
    end

    context "when activity_type is 'comment'" do
      context "and comment is blank" do
        subject { build(:project_activity, activity_type: 'comment', comment: nil) }
        it "is not valid and adds an error for comment" do
          expect(subject).not_to be_valid
          expect(subject.errors[:comment]).to include("can't be blank")
        end
      end

      context "and comment is present" do
        subject { build(:project_activity, activity_type: 'comment', comment: "This is a valid comment") }
        it "is valid" do
          expect(subject).to be_valid
        end
      end
    end

    context "when activity_type is neither 'status_change' nor 'comment'" do
      subject { build(:project_activity, activity_type: 'invalid_type') }
      it "is not valid and adds an error on activity_type" do
        expect(subject).not_to be_valid
        expect(subject.errors[:activity_type]).to include("must be either 'comment' or 'status_change'")
      end
    end
  end
end
