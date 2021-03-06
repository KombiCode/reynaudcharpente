module.exports = {
  mode: 'jit',
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/components/**/*.html.erb',
    './app/components/**/*.rb'
  ],
  plugins: [
    require('@tailwindcss/custom-forms')
  ],
  theme: {
    extend: {
      colors: {
        brandGreen: "#a1d02f",
        brandYellow: "#eacd26",
        brandBrown: "#4c1212",
        socialFacebook: "#0f90f3",
        socialInstagram: "#d61e66",
        brandActive: "#4c1212"
      },
      fontFamily: {
        akaya: "Akaya Telivigala",
        adventpro: ["AdventPro", "sans-serif"],
        dosis: ["Dosis", "sans-serif"],
        signika: ["Signika", "sans-serif"],
        jost: ["Jost", "sans-serif"]
      }
    },
  }
}