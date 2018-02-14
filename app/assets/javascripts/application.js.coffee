#= require libs/vue.min
#= require libs/jquery.min
#= require libs/popper.min
#= require libs/bootstrap-vue.min
#= require libs/jquery-ujs.min

#= require libs/mijyu

#= require components/app-popup-login
#= require components/app-navbar-menu
#= require components/app-navbar-right

#= require components/m-loading-spinner

#= require_self

# Set up CSRF token for AJAX
$.ajaxSetup {
  headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') }
}

Vue.use({
  install: (Vue, options) ->
    Object.defineProperty(Vue.prototype, 'uniqId', {
      get: -> this._uid
    })
})

@$App = {
  model: {}
  methods: {}
}

@$Route = {}

@$App.initialize = =>
  if data = $('#page-data').text().trim()
    $.extend(@$App.model, JSON.parse(data))
    $.extend(@$Route, @$App.model.routes)

  @$App.$vue = new Vue {
    el: '#vue-app-root'
    data: @$App.model
    methods: @$App.methods
  }
