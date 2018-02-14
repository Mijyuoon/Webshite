# Add "lib" directory to Ruby load path
$LOAD_PATH << Rails.root.join('lib')

require 'sprockets/vue'

require 'mijyu/hashes'
require 'mijyu/markdown'

require 'include/session_manager'