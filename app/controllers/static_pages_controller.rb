class StaticPagesController < ApplicationController
  def home
    @activities = Activity.all
  end
  def news
  end
  def achievements
  end
  def opinions
  end
  def company_history
    add_breadcrumb(t('breadcrumb_company'))
  end
  def about
  end
  def privacy
  end
  def terms
  end
end
