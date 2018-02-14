module Mijyu
  module Markdown
    RENDER_OPTIONS = {
      escape_html: true,
      hard_wrap: true,
      prettify: true,
    }

    EXTENSIONS = {
      underline: true,
      highlight: true,
      strikethrough: true,
      fenced_code_blocks: true,
      disable_indented_code_blocks: true,
    }

    class << self
      def parse(text)
        @renderer ||= Redcarpet::Render::HTML.new(RENDER_OPTIONS)
        @markdown ||= Redcarpet::Markdown.new(@renderer, EXTENSIONS)
        @markdown.render(text).html_safe
      end
    end
  end
end