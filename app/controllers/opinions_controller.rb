class OpinionsController < ApplicationController
  def index
    @opinions = Opinion.all.order("published_at DESC")
  end
end
