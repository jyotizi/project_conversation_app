require 'rails_helper'

RSpec.describe ProjectActivityCreatorService, type: :service do
  let(:user) { create(:user) }
  let(:project) { create(:project, status: 'open') }

  describe "#call" do
    context "when activity_type is 'status_change'" do
      let(:new_status) { 'in_progress' }
      let(:params) { { activity_type: 'status_change', new_status: new_status } }
      subject { described_class.new(project, params, user) }

      context "when the status change is successful" do
        it "updates the project's status and creates a project_activity" do
          result = subject.call
          expect(result).to be_truthy

          project.reload
          expect(project.project_activities.count).to eq(1)
          expect(project.status).to eq(new_status)

          activity = project.project_activities.last
          expect(activity.activity_type).to eq('status_change')
          expect(activity.old_status).to eq('open')
          expect(activity.new_status).to eq(new_status)
          expect(activity.user).to eq(user)
        end
      end

      context "when the status change fails" do
        before do
          allow(project).to receive(:update!).and_raise(ActiveRecord::RecordInvalid.new(project))
        end

        it "returns false and sets an error_message" do
          result = subject.call
          expect(result).to be_falsey
          expect(subject.error_message).not_to be_empty
        end
      end
    end

    context "when activity_type is 'comment'" do
      let(:comment_text) { 'This is a test comment.' }
      let(:params) { { activity_type: 'comment', comment: comment_text } }
      subject { described_class.new(project, params, user) }

      context "when the comment creation is successful" do
        it "creates a project_activity with the comment" do
          result = subject.call
          expect(result).to be_truthy
          expect(project.project_activities.count).to eq(1)

          activity = project.project_activities.last
          expect(activity.activity_type).to eq('comment')
          expect(activity.comment).to eq(comment_text)
          expect(activity.user).to eq(user)
        end
      end

      context "when the comment creation fails" do
        let(:params) { { activity_type: 'comment', comment: '' } }

        it "returns false and sets an error_message" do
          result = subject.call
          expect(result).to be_falsey
          expect(subject.error_message).not_to be_empty
        end
      end
    end

    context "when activity_type is invalid" do
      let(:params) { { activity_type: 'invalid_type' } }
      subject { described_class.new(project, params, user) }

      it "returns false and sets the error_message to 'Invalid activity type provided.'" do
        result = subject.call
        expect(result).to be_falsey
        expect(subject.error_message).to eq('Invalid activity type provided.')
      end
    end
  end
end
