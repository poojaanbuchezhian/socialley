class Faq < ApplicationRecord
  belongs_to :user
  acts_as_indexed :fields => ['bio', 'skillz', 'schools', 'companies', 'music', 'movies', 'television', 'books', 'magazines']
  QUESTIONS = %w(bio skillz schools companies music movies television books magazines)
  FAVORITES = %w(skillz schools companies music movies television books magazines)
  TEXT_ROWS = 10
  TEXT_COLS = 40

  validates_length_of QUESTIONS, :maximum => DB_TEXT_MAX_LENGTH

  def self.initialize
    super
    QUESTIONS.each do |question|
      self[question] = ""
    end
  end
end
