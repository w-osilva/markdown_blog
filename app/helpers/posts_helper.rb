module PostsHelper
  def post_url_render(file)
    params = file.split("/")
    post_render_html_url(params[0], params[1])
  end

  def post_url_html(file)
    post_url = File.join(root_url, 'posts')
    post_url = File.join(post_url, file) if file.present?
    post_url
  end

  def post_label(status)
    case status.to_s
      when 'new' then 'default'
      when 'published' then 'success'
      when 'disabled' then 'danger'
      else 'default'
    end
  end
end
