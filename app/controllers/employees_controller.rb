class EmployeesController < ApplicationController
  before_action :set_breadcrumbs

  def index
    @employees = Employee.all
    add_breadcrumb(t('breadcrumb_employees'))
  end

  def show
    @employee = Employee.find params[:id]
    add_breadcrumb(t('breadcrumb_employees'), employees_path)
    add_breadcrumb(@employee.name)
  end

  def edit
    @employee = Employee.find params[:id]
    authorize @employee
    add_breadcrumb(t('breadcrumb_employees'), employees_path)
    add_breadcrumb(@employee.name, employee_path(@employee))
    add_breadcrumb('Edit')
  end

  def update
    @employee = Employee.find(params[:id])
    authorize @employee
    if @employee.update(employee_params)
      redirect_to @employee
    else
      render :edit
    end
  end

  private

  def set_breadcrumbs
    add_breadcrumb(t('breadcrumb_company'), history_path)
  end

  def employee_params
    params.require(:employee).permit(:name, :job_title, :about)
  end

end
