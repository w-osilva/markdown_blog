class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :text_md, presence: true
  validates :user, presence: true

  after_create :parse_markdown_to_html

  extend Enumerize
  enumerize :status, in: [
      :new, :published, :disabled
  ], predicates: true, scope: true, default: :new

  default_scope {where(status: [:new, :published]).order(created_at: :desc)}

  def parse_markdown_to_html
    self[:text_html] = MarkdownParser::convert_to_html text_md
    self[:slug] = make_slug
    self[:file] = make_file
    self[:status] = :published
    save
  end

  private
  def make_slug
    slug = title.strip.parameterize.underscore
    registered = Post.where("slug LIKE ?", slug)
    if registered.present?
      slug = "#{slug}_#{registered.size}"
    end
    slug
  end

  def make_file
    "#{slug}.html"
  end

end
