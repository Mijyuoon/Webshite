require 'sprockets'
require 'nokogiri'
require 'haml'

require 'sprockets/vue/haml'
require 'sprockets/vue/script'
require 'sprockets/vue/style'

module Sprockets
  module Vue
    VERSION = '0.1.0'
  end

  if respond_to?(:register_transformer)
    register_mime_type 'text/vue-haml', extensions: ['.vue.haml'], charset: :unicode
    register_transformer 'text/vue-haml', 'application/javascript', Vue::Script
    register_transformer 'text/vue-haml', 'text/css', Vue::Style

    register_preprocessor 'text/vue-haml', Vue::Haml
    register_processor 'text/vue-haml', Sprockets::DirectiveProcessor
  end
end