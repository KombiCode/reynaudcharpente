class StaticPagesController < ApplicationController
  def home
    @activities = Activity.all
  end
  def company_history
    add_breadcrumb(t('breadcrumb_company'))
  end
  def about
  end
end
