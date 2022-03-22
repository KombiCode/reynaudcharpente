class OpinionsStatistics
  attr_reader :average, :count, :neutral_count, :bad_count, :good_count
  def initialize(average, count, neutrals, bads)
    @average = average
    @count = count
    @neutral_count = neutrals
    @bad_count = bads
    @good_count = count - neutrals - bads
  end 
end