class EmployeesController < ApplicationController
  before_action :set_breadcrumbs

  def index
    @employees = Employee.all
  end

  private

  def set_breadcrumbs
    add_breadcrumb("L'équipe", employees_path)
  end

end
