json.extract! post, :id, :title, :slug, :url, :text_md, :text_html, :user_id, :created_at, :updated_at
json.url post_url(post, format: :json)
