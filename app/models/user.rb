class User < ApplicationRecord
  authenticates_with_sorcery!
  scope :admin_users, -> { where(admin: true) }
  scope :nonadmin_users, -> { where(admin: false) }
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true
end
