class ApplicationController < ActionController::Base
  add_flash_types :success
  helper_method :breadcrumbs

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  def breadcrumbs
    @breadcrumbs ||= []
  end

  def add_breadcrumb(name, path = nil)
    breadcrumbs << Breadcrumb.new(name, path)
  end
end
