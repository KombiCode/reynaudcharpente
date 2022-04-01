class Opinion < ApplicationRecord
  has_many :ratings
  has_many :categories, through: :ratings

  def smiley_for_rating
    smiley_svg_filename = "smiley-positive.svg"
    if bad_rating
      smiley_svg_filename = "smiley-negative.svg"
    elsif neutral_rating
      smiley_svg_filename = "smiley-neutral.svg"
    end
    smiley_svg_filename
  end

  def rating_average
    sum = 0
    ratings.each do |rating|
      sum += rating.note
    end
    (sum / ratings.count).round(1)
  end

  def bad_rating
    rating_average < 5.1
  end
  def neutral_rating
    ra = rating_average
    ra > 5.1 && ra < 7.5
  end
  def good_rating
    rating_average >= 7.5
  end

  def filter_rating
    if good_rating
      "good"
    elsif neutral_rating
      "neutral"
    else
      "bad"
    end
  end

end
