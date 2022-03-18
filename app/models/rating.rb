class Rating < ApplicationRecord
  belongs_to :category
  belongs_to :opinion
end
