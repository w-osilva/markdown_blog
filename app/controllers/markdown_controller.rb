class MarkdownController < ApplicationController

  def to_html
    @html = MarkdownParser.to_html(markdown_params)
    render text: @html, layout: false
  end

  private
  def markdown_params
    params[:markdown].require(:text_md)
  end

end
