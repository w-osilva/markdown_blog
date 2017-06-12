class Post < ApplicationRecord
  extend Enumerize

  belongs_to :user

  validates :title, presence: true
  validates :text_md, presence: true
  validates :user, presence: true

  before_create :default_attributes
  after_save :process_markdown

  enumerize :status, in: [:new, :published, :disabled], default: :new, predicates: true, scope: true

  default_scope {where(status: [:new, :published]).order(created_at: :desc)}

  def process_markdown
    PostJob.perform_later(post_id: id)
  end

  private
  def default_attributes
    slug = title.strip.parameterize.underscore
    registered = Post.where("slug LIKE ?", slug)
    slug = "#{slug}_#{registered.size}" if registered.present?

    self[:slug] = slug
    self[:status] = :new
    self[:file] = "#{slug}.html"
  end

end
