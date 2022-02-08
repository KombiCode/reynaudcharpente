class Activity < ApplicationRecord
  extend FriendlyId
  friendly_id :name, :use => :slugged
  has_rich_text :content
  validates_presence_of :name, :slug
end
