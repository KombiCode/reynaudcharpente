class Opinion < ApplicationRecord
  has_many :ratings
  has_many :categories, through: :ratings

  def rating_average
    sum = 0
    ratings.each do |rating|
      sum += rating.note
    end
    (sum / ratings.count).round(1)
  end
end
