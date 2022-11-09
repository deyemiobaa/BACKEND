class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password password_confirmation])
  end

  def authenticate_user!
    if user_signed_in?
      super
    else
      render json: { error: 'Not Authorized' }, status: :unauthorized
    end
  end
end
