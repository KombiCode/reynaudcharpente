class SkillsController < ApplicationController
  before_action :set_breadcrumbs

  def index
    @skills = Skill.all
  end

  def new
    @skill = Skill.new
    authorize @skill
  end

  def create
    @skill = Skill.new skill_params
    authorize @skill
    if @skill.save
      redirect_to skills_path
    else
      render :new
    end
  end

  private

  def skill_params
    params.require(:skill).permit(:title, :description)
  end

  def set_breadcrumbs
    add_breadcrumb(t('breadcrumb_company'), history_path)
    add_breadcrumb(t('breadcrumb_skills'))
  end
end
