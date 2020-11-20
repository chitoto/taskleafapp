class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def authenticate_user
    unless current_user
      flash[:notice] = t('notice.login_needed')
      redirect_to new_session_path
    end
  end

end
