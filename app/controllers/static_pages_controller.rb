class StaticPagesController < ApplicationController
  def home
  end
  def company_history
    add_breadcrumb(t('breadcrumb_company'))
  end
end
