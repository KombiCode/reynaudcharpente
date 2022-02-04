class ZipcodesController < ApplicationController

  def index
    @zipcodes = Zipcode.where("code like ?", "#{params[:q]}%")
    render layout: false
  end

end
