class Comment < ApplicationRecord
  validates :text, presence: true, uniqueness: true
  belongs_to :user
  belongs_to :post
end
