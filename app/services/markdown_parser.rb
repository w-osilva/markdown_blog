class MarkdownParser

  def self.to_html(text_md)
    render = Redcarpet::Render::HTML.new({
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    })

    markdown = Redcarpet::Markdown.new(render, {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    })

    markdown.render(text_md)
  end

end