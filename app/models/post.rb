class Post < ActiveRecord::Base
  belongs_to :user
  validates :content, length: { maximum: 141 }, presence: true
  validates :user_id, presence: true
end
