class Blog < ApplicationRecord
  belongs_to :user
  has_many :posts, -> { order 'created_at desc'}
end
