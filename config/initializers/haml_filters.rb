# Register Stylus filter to work with HAML
Haml::Filters.register_tilt_filter('Styl', template_class: Tilt::StylusTemplate, extend: 'Css')