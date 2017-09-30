module Sprockets::Vue
  class Haml
    def call(input)
      haml = ::Haml::Engine.new(input[:data])
      { data: haml.render }
    end

    def self.call(input)
      @instance ||= self.new
      @instance.call(input)
    end
  end
end