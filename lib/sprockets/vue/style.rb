module Sprockets::Vue
  class Style
    def call(input)
      data, key = input[:data], self.class.cache_key

      input[:cache].fetch([key, input[:source_path], data]) do
        parsed = Nokogiri::HTML.parse(data)

        if (style = parsed.css('style').first)
          { data: style.content }
        else
          { data: '' }
        end
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