class Page < ApplicationRecord
  include Leafable

  cattr_accessor :preview_renderer do
    renderer = Redcarpet::Render::HTML.new(ActionText::Markdown::DEFAULT_RENDERER_OPTIONS)
    Redcarpet::Markdown.new(renderer, ActionText::Markdown::DEFAULT_MARKDOWN_EXTENSIONS)
  end

  has_markdown :body

  def html_preview
    preview_renderer.render(body_preview)
  end

  private
    def body_preview
      body.content.to_s.first(1024)
    end
end
