class Activity < ApplicationRecord
  extend FriendlyId
  friendly_id :name, :use => :slugged
  has_rich_text :content
  has_many_attached :photos
  validates_presence_of :name, :slug
end
