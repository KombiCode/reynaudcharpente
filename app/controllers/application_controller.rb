class ApplicationController < ActionController::Base
  include Pundit
  add_flash_types :success
  helper_method :breadcrumbs
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  def breadcrumbs
    @breadcrumbs ||= []
  end

  def add_breadcrumb(name, path = nil)
    breadcrumbs << Breadcrumb.new(name, path)
  end

  private

  def user_not_authorized
    redirect_to(request.referrer || root_path)
  end

end
