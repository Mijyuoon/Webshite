module Sprockets::Vue
  class Script
    include ActionView::Helpers::JavaScriptHelper

    def call(input)
      name, data, key = input[:name], input[:data], self.class.cache_key

      input[:cache].fetch([key, input[:source_path], data]) do
        parsed = Nokogiri::HTML.parse(data)

        result = ['var module = {exports: {}};']

        if (script = parsed.css('script').first)
          result << "#{script.content};"
        end

        if (template = parsed.css('template').first)
          tpldata = j(template.inner_html.strip)
          result << "module.exports.template = '#{tpldata}';"
        end

        compname = name.match(%r{([^/]+)$}).to_s.gsub('_', '-')
        result << "Vue.component('#{compname}', module.exports);"

        result = result.join("\n")
        { data: "(function(){\n#{result}\n}).call(this);" }
      end
    end

    def self.cache_key
      [self.name, VERSION].freeze
    end

    def self.call(input)
      @instance ||= self.new
      @instance.call(input)
    end
  end
end