class ProjectActivitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project

  def create
    activity_params = project_activity_params
    creator = ProjectActivityCreatorService.new(@project, activity_params, current_user)
    if creator.call
      redirect_to @project, notice: "Activity recorded successfully."
    else
      redirect_to @project, alert: creator.error_message
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def project_activity_params
    params.require(:project_activity).permit(:activity_type, :new_status, :comment)
  end
end
