class ActivitiesController < ApplicationController
  before_action :find_activity, only: [:show]
  before_action :set_breadcrumbs, only: [:show]

  def index
    @activities = Activity.all
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
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

  def set_breadcrumbs
    add_breadcrumb(@activity.name)
  end
end
