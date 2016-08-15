class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :create_fake_session

  rescue_from Errors::NotFound, with: :not_found_error

  helper_method :current_account, :current_deployment

  private

  def current_deployment
    @current_deployment ||= Deployment.find(params[:deployment_id])
  end

  def current_account
    @current_account ||= Account.find(session[:account_id])
  end

  def create_fake_session
    session[:account_id] = 1337
  end

  def not_found_error exception
    render "errors/not_found", layout: 'megatron/errors',
      locals: { message: exception.message },
      status: :not_found
  end

end
