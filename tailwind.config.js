module.exports = {
  mode: 'jit',
  purge: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        brandGreen: "#a1d02f",
        brandYellow: "#eacd26",
        brandBrown: "#4c1212",
      },
    },
  }
}


