module Response
  extend ActiveSupport::Concern

  private

  def render_success_response(resource, path, message:)
    respond_to do |format|
      format.html { redirect_to path, notice: message }
    end
  end

  def render_error_response(resource, view)
    respond_to do |format|
      format.html { render view }
    end
  end

  def render_destroy_response(path, message:)
    respond_to do |format|
      format.html { redirect_to path, notice: message }
    end
  end
end
