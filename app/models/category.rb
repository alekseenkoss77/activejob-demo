class Category < ApplicationRecord
  has_many :photos

  validates :title, uniqueness: true, presence: true
end
