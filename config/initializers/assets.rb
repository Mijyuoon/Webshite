# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Make asset precompilation use the manifest file.
Rails.application.config.assets.precompile = %w( manifest.js )

# Add vendor assets to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets')