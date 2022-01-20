class SkillsController < ApplicationController
  before_action :set_breadcrumbs

  def index
    @skills = Skill.all
  end

  private

  def set_breadcrumbs
    add_breadcrumb(t('breadcrumb_skills'), skills_path)
  end
end
