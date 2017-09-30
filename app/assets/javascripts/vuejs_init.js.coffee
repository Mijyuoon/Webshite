if vue_data = $('#vue-page-data').text()
  $.extend(@app.$model, JSON.parse(vue_data))

@app.$vue = new Vue {
  el: '#vue-app-root'
  data: @app.$model
  methods: @app.$method
}