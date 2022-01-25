class EmployeesController < ApplicationController
  before_action :set_breadcrumbs

  def index
    @employees = Employee.all
  end

  private

  def set_breadcrumbs
    add_breadcrumb(t('breadcrumb_company'), history_path)
    add_breadcrumb(t('breadcrumb_employees'))
  end

end
