class StaticPagesController < ApplicationController
  def home
    @activities = Activity.all
    @markers = [
                {
                  lat: 45.269936,
                  lng: 5.8918449,
                  image_url: helpers.asset_url("rc-logo-color"),
                  info_window: render_to_string(partial: "info_window",
                                                locals: { place: { name: t(".office_name"),
                                                                   address: t(".office_address")
                                                                 }
                                                        })
                },
                {
                  lat: 45.2199478,
                  lng: 5.8586923,
                  image_url: helpers.asset_url("rc-logo-color"),
                  info_window: render_to_string(partial: "info_window",
                                                locals: { place: { name: t(".workshop_name"),
                                                                   address: t(".workshop_address")
                                                                 }
                                                        })
                }
              ]
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
