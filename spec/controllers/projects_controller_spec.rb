require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:user)    { create(:user) }
  let(:project) { create(:project) }

  before { sign_in user }

  describe "GET #index" do
    let!(:project1) { create(:project) }
    let!(:project2) { create(:project) }

    it "assigns all projects to @projects" do
      get :index
      expect(assigns(:projects)).to match_array([project1, project2])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "assigns the requested project to @project" do
      get :show, params: { id: project.id }
      expect(assigns(:project)).to eq(project)
    end

    it "renders the show template" do
      get :show, params: { id: project.id }
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "assigns a new project to @project" do
      get :new
      expect(assigns(:project)).to be_a_new(Project)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      let(:project_params) { attributes_for(:project) }

      it "creates a new project" do
        expect {
          post :create, params: { project: project_params }
        }.to change(Project, :count).by(1)
      end

      it "redirects to the newly created project with a notice" do
        post :create, params: { project: project_params }
        expect(response).to redirect_to(Project.last)
        expect(flash[:notice]).to eq("Project was successfully created.")
      end
    end

    context "with invalid attributes" do
      before do
        allow_any_instance_of(Project).to receive(:save).and_return(false)
      end

      let(:invalid_params) { attributes_for(:project) }

      it "does not create a new project" do
        expect {
          post :create, params: { project: invalid_params }
        }.not_to change(Project, :count)
      end

      it "renders the new template" do
        post :create, params: { project: invalid_params }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    it "assigns the requested project to @project" do
      get :edit, params: { id: project.id }
      expect(assigns(:project)).to eq(project)
    end

    it "renders the edit template" do
      get :edit, params: { id: project.id }
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      let(:new_attributes) do
        { title: "Updated Title", description: "Updated Description", status: "updated" }
      end

      it "updates the project" do
        patch :update, params: { id: project.id, project: new_attributes }
        project.reload
        expect(project.title).to eq("Updated Title")
        expect(project.description).to eq("Updated Description")
        expect(project.status).to eq("updated")
      end

      it "redirects to the root path with a notice" do
        patch :update, params: { id: project.id, project: new_attributes }
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq("Project was successfully updated.")
      end
    end

    context "with invalid attributes" do
      before do
        allow_any_instance_of(Project).to receive(:update).and_return(false)
      end

      let(:invalid_attributes) { { title: "", description: "", status: "" } }

      it "does not update the project" do
        original_title = project.title
        patch :update, params: { id: project.id, project: invalid_attributes }
        project.reload
        expect(project.title).to eq(original_title)
      end

      it "renders the edit template" do
        patch :update, params: { id: project.id, project: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:project_to_delete) { create(:project) }

    it "deletes the project" do
      expect {
        delete :destroy, params: { id: project_to_delete.id }
      }.to change(Project, :count).by(-1)
    end

    it "redirects to the projects index with a notice" do
      delete :destroy, params: { id: project_to_delete.id }
      expect(response).to redirect_to(projects_path)
      expect(flash[:notice]).to eq("Project was successfully deleted.")
    end
  end
end
