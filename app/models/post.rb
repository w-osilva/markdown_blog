require 'fileutils'
class Post < ApplicationRecord
  extend Enumerize

  belongs_to :user

  validates :title, presence: true
  validates :text_md, presence: true
  validates :user, presence: true

  before_create :set_default_attributes
  after_save :process_markdown

  enumerize :status, in: [:new, :published, :disabled], default: :new, predicates: true, scope: true

  default_scope {where(status: [:new, :published]).order(created_at: :desc)}

  # -----------------------------------------------------------------
  # Class methods
  # -----------------------------------------------------------------
  def self.post_path(path = nil)
    post_path =  Rails.public_path.join('posts')
    post_path = post_path.join(path) if path.present?
    post_path
  end

  # -----------------------------------------------------------------
  # Instance methods
  # -----------------------------------------------------------------
  def process_markdown
    PostMarkdownJob.perform_later(post_id: id)
  end

  def publish
    setup_path
    file_path = self.class.post_path.join(file)
    begin
      File.open(file_path, "w:UTF-8") {|f| f.puts(text_html)}
      self[:status] = :published
      save
    rescue => e
      # log error on publish html
      puts e.message
    end
  end

  def disable
    self[:status] = :disabled
    save
  end

  private
  def set_default_attributes
    slug = slugify(title)
    registered = Post.where("slug LIKE ?", slug)
    slug = "#{slug}_#{registered.size}" if registered.present?

    self[:slug] = slug
    self[:status] = :new
    self[:file] = File.join(slugify(user.nickname), "#{slug}.html")
  end

  def slugify(string)
    string.strip.parameterize.underscore
  end

  def setup_path
    user_dir = File.dirname(file)
    user_path = self.class.post_path.join(user_dir)
    FileUtils.mkdir_p(user_path) unless File.directory?(user_path)
  end

end
