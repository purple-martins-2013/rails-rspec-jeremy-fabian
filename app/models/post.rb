class Post < ActiveRecord::Base
  attr_accessible :title, :content, :is_published

  scope :recent, order: "created_at DESC", limit: 5

  before_save :titleize_title, :slugify_title
  validates_presence_of :title, :content

  private

  def titleize_title
    self.title = title.titleize
  end

  def slugify_title
    self.slug = self.title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end
end
