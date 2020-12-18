import "./bootstrap"

const channels = require.context('./components', true, /\.scss$/)
channels.keys().forEach(channels)
