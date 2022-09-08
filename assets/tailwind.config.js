// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

let plugin = require('tailwindcss/plugin')

module.exports = {
  content: [
    './js/**/*.js',
    '../lib/*_web.ex',
    '../lib/*_web/**/*.*ex',
  ],
  theme: {
    extend: {
      boxShadow: {
        '3xl': '0 0 10px 10px rgb(0 0 0 / 0.6)'
      },
      colors: {
        background: {
          primary: '#090909',
          secondary: '#161616'
        },
        card: {
          primary: '#191919',
          secondary: '#333333',
        },
        quality: {
          superior: '#3A90FB',
          epic: '#A32FF4',
          legendary: '#E9C82D'
        },
        discord: {
          primary: '#5865F2',
          secondary: '#454FBF',
          dark: '#23272A'
        }
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    plugin(({addVariant}) => addVariant('phx-no-feedback', ['&.phx-no-feedback', '.phx-no-feedback &'])),
    plugin(({addVariant}) => addVariant('phx-click-loading', ['&.phx-click-loading', '.phx-click-loading &'])),
    plugin(({addVariant}) => addVariant('phx-submit-loading', ['&.phx-submit-loading', '.phx-submit-loading &'])),
    plugin(({addVariant}) => addVariant('phx-change-loading', ['&.phx-change-loading', '.phx-change-loading &']))
  ]
}
