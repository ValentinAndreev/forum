class Post < ApplicationRecord
  validates :name, :text, presence: true, uniqueness: true
  belongs_to :user
end
