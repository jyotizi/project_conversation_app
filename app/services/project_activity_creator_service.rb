class ProjectActivityCreatorService
  attr_reader :project, :params, :user, :activity, :error_message

  def initialize(project, params, user)
    @project = project
    @params = params
    @user = user
  end

  def call
    case params[:activity_type]
    when 'status_change'
      create_status_change
    when 'comment'
      create_comment
    else
      @error_message = 'Invalid activity type provided.'
      false
    end
  end

  private

  def create_status_change
    new_status = params[:new_status]
    @activity = project.project_activities.build(
      activity_type: 'status_change',
      old_status: project.status,
      new_status: new_status,
      user: user
    )

    Project.transaction do
      project.update!(status: new_status)
      @activity.save!
    end
    true
  rescue ActiveRecord::RecordInvalid => e
    @error_message = e.message
    false
  end

  def create_comment
    @activity = project.project_activities.build(
      activity_type: 'comment',
      comment: params[:comment],
      user: user
    )
    if @activity.save
      true
    else
      @error_message = @activity.errors.full_messages.join(', ')
      false
    end
  end
end
