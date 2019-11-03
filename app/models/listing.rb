class Listing < ApplicationRecord
  belongs_to :breed
  enum sex:{female: 0, male:1 }

  

  validates :state, inclusion: { in: %w(VIC NSW WA NT TAS ACT QLD SA)}

  validates :title, :state, :description, :sex, :price, :breed, presence: true

  has_one_attached :picture
  belongs_to :user

end
