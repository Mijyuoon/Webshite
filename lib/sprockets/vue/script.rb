module Sprockets::Vue
  class Script
    include ActionView::Helpers::JavaScriptHelper

    SCRIPT_REGEX = %r{<script>(.*?)</script>}m
    TEMPLATE_REGEX = %r{<template>(.*?)</template>}m

    FILENAME_REGEX = %r{([^/]+)$}

    def call(input)
      name, data, key = input[:name], input[:data], self.class.cache_key

      input[:cache].fetch([key, input[:source_path], data]) do
        # This is *so* bad, I know :C
        result = ['var module = {exports: {}};']

        data.scan(SCRIPT_REGEX).each {|x| result << "#{x.first};" }

        template = data.scan(TEMPLATE_REGEX).map(&:first).join("\n")
        result << "module.exports.template = '#{j(template)}';"

        compname = name.match(FILENAME_REGEX).to_s.gsub('_', '-')
        result << "Vue.component('#{j(compname)}', module.exports);"

        { data: "(function(){\n#{result.join("\n")}\n}).call(this);" }
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