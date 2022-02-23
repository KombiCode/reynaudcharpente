class ActivitiesController < ApplicationController
  before_action :find_activity, only: [:show, :edit, :update]
  # before_action :set_breadcrumbs, only: [:show]

  def index
    @activities = Activity.all
  end

  def show
    add_breadcrumb(@activity.name)
  end

  def new
  end

  def create
  end

  def edit
    authorize @activity
    add_breadcrumb(t('breadcrumb_activities'), activities_path)
    add_breadcrumb(@activity.name, activity_path(@activity))
    add_breadcrumb('Edit')
  end

  def update
    authorize @activity
    if @activity.update(activity_params)
      redirect_to @activity
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def find_activity
    @activity = Activity.friendly.find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(:name, :description, :content)
  end  

  # def set_breadcrumbs
  #   add_breadcrumb(@activity.name)
  # end
end
