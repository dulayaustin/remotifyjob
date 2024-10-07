module.exports = {
  content: [
    "./app/views/**/*.html.erb",
    "./app/components/**/*.{erb,html}",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
  ],
  plugins: [require("@tailwindcss/forms")],
};
