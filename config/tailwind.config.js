const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        primary: '#060910',
        secondary: '#BD3A4A',
        main: '#1F2937',
        error: '#F87084'
      },
      gradientColorStops: {
        'custom-pink': '#FF6B6B',
        'custom-purple': '#9F7AEA',
      },
      linearGradientColors: {
        'pink-to-purple': ['var(--custom-pink)', 'var(--custom-purple)'],
      },
      fontSize: {
        // '5xl': '3.4rem', 
      },
      lineHeight: {
        'normal': 1.2,
        // 'tight': 1.25,
        // 'normal': 0.5,
        // 'relaxed': 1.75,
        // 'loose': 2,
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ],
};
