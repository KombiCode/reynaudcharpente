class Category < ApplicationRecord
  has_many :ratings
  has_many :opinions, through: :ratings
end
