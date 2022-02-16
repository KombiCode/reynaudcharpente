class SkillsController < ApplicationController
  before_action :set_breadcrumbs

  def index
    @skills = Skill.all
    add_breadcrumb(t('breadcrumb_skills'))
  end

  def show
    @skill = Skill.find params[:id]
    add_breadcrumb(t('breadcrumb_skills'), skills_path)
    add_breadcrumb(@skill.title)
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

  def edit
    @skill = Skill.find params[:id]
    authorize @skill
    add_breadcrumb(t('breadcrumb_skills'), skills_path)
    add_breadcrumb(@skill.title, skill_path(@skill))
    add_breadcrumb('Edit')
  end

  def update
    @skill = Skill.find(params[:id])
    authorize @skill
    if @skill.update(skill_params)
      redirect_to @skill
    else
      render :edit
    end
  end

  def destroy
    @skill = Skill.find params[:id]
    authorize @skill
    @skill.destroy
    redirect_to skills_path
  end

  private

  def skill_params
    params.require(:skill).permit(:title, :description)
  end

  def set_breadcrumbs
    add_breadcrumb(t('breadcrumb_company'), history_path)
  end
end
