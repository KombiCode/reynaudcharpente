class EmployeesController < ApplicationController
  before_action :set_breadcrumbs

  def index
    @employees = Employee.with_attached_photo
    add_breadcrumb(t('breadcrumb_employees'))
  end

  def show
    @employee = Employee.find params[:id]
    add_breadcrumb(t('breadcrumb_employees'), employees_path)
    add_breadcrumb(@employee.name)
  end

  def new
    @employee = Employee.new
    authorize @employee
  end

  def create
    @employee = Employee.new employee_params
    authorize @employee
    if @employee.save
      redirect_to employees_path
    else
      render :new
    end
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

  def destroy
    @employee = Employee.find params[:id]
    authorize @employee
    @employee.destroy
    redirect_to employees_path
  end

  private

  def set_breadcrumbs
    add_breadcrumb(t('breadcrumb_company'), history_path)
  end

  def employee_params
    params.require(:employee).permit(:name, :job_title, :about, :photo)
  end

end
