class OpinionsController < ApplicationController
  def index
    @opinions = Opinion.all.order("published_at DESC")
    @op_statistics = statistics
  end

  private
  def statistics
    sum = 0
    items_count = 0
    neutral_count = 0
    bad_count = 0
    Opinion.all.find_each do |op|
      sum += op.rating_average
      items_count += 1
      if op.bad_rating
        bad_count += 1
      elsif op.neutral_rating
        neutral_count += 1
      end
    end
    OpinionsStatistics.new((sum / items_count).round(1), items_count, neutral_count, bad_count) unless items_count == 0
  end
end
