class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_event

  def after_sign_in_path_for(resource)
    return results_graph_votes_path if resource.is_a?(User) && resource.graph_only?
    super
  end

  private

  def set_event
    @my_event = Event.find_by(active: 1)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:user_name])
  end
end
