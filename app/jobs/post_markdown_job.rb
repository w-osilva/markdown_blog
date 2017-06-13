class PostMarkdownJob < ApplicationJob
  queue_as :post_markdown

  def perform(**args)
    post_id = args[:post_id]
    post = Post.find(post_id)

    # Prevents infinite loop in after_save callback
    Post.without_callback(:save, :after, :process_markdown) do
      post.text_html = MarkdownParser::to_html(post.text_md)
      post.save
    end

    # Send message to publish_queue
    PostPublishJob.perform_now(post_id: post_id)
  end

end