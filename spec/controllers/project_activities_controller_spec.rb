require 'rails_helper'

RSpec.describe ProjectActivitiesController, type: :controller do
  let(:user)    { create(:user) }
  let(:project) { create(:project) }

  let(:activity_params) do
    {
      activity_type: 'create',
      new_status:    'active',
      comment:       'Test comment'
    }
  end

  let(:valid_params) do
    {
      project_id: project.id,
      project_activity: activity_params
    }
  end

  before { sign_in user }

  describe 'POST #create' do
    subject { post :create, params: valid_params }
    context 'when the activity creation is successful' do
      let(:service_double) { double("ProjectActivityCreatorService", call: true) }
      before do
        expect(ProjectActivityCreatorService).to receive(:new) do |proj, permitted_params, current_user|
          expect(proj).to eq(project)
          expect(current_user).to eq(user)
          expect(permitted_params).to be_an_instance_of(ActionController::Parameters)
          expect(permitted_params.permitted?).to be true
          expect(permitted_params.to_h).to eq(activity_params.stringify_keys)
          service_double
        end
      end

      it 'redirects to the project with a success notice' do
        subject
        expect(response).to redirect_to(project)
        expect(flash[:notice]).to eq("Activity recorded successfully.")
      end
    end

    context 'when the activity creation fails' do
      let(:error_message) { "Unable to create activity" }
      let(:service_double) { double("ProjectActivityCreatorService", call: false, error_message: error_message) }

      before do
        expect(ProjectActivityCreatorService).to receive(:new) do |proj, permitted_params, current_user|
          expect(proj).to eq(project)
          expect(current_user).to eq(user)
          service_double
        end
      end

      it 'redirects to the project with an alert message' do
        subject
        expect(response).to redirect_to(project)
        expect(flash[:alert]).to eq(error_message)
      end
    end
  end
end
