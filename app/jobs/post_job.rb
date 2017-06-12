class PostJob < ApplicationJob
  queue_as :convert_markdown

  rescue_from(Exception) do
    # Here we can log the error somewhere for easy tracking
    retry_job wait: 1.minutes, queue: :convert_markdown
  end

  def perform(**args)
    post_id = args[:post_id]

    # Prevents infinite loop in after_save callback
    Post.without_callback(:save, :after, :process_markdown) do
      post = Post.find(post_id)
      post.text_html = MarkdownParser::to_html(post.text_md)
      post.status = :published
      post.save
    end
  end

end