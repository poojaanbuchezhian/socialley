class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates_presence_of :body, :post, :user
  validates_length_of :body, :maximum => DB_TEXT_MAX_LENGTH
  validates_uniqueness_of :body, :scope => [:post_id, :user_id]
  def duplicate?
    c = Comment.find_by_post_id_and_user_id_and_body(post, user, body)
    self.id = c.id unless c.nil?
    not c.nil?
  end
  def authorized?(user)
    post.blog.user == user
  end
end
