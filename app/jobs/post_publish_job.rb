class PostPublishJob < ApplicationJob
  queue_as :post_publish

  def perform(**args)
    post_id = args[:post_id]
    post = Post.find(post_id)

    # Prevents infinite loop in after_save callback
    Post.without_callback(:save, :after, :process_markdown) do
      post.publish
    end
  end

end