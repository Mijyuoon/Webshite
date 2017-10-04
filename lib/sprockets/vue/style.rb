module Sprockets::Vue
  class Style
    STYLE_REGEX = %r{<style>(.*?)</style>}m

    def call(input)
      data, key = input[:data], self.class.cache_key

      input[:cache].fetch([key, input[:source_path], data]) do
        style = data.scan(STYLE_REGEX).map(&:first).join("\n")

        { data: style }
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