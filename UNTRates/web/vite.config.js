import { fileURLToPath, URL } from 'node:url'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import vueDevTools from 'vite-plugin-vue-devtools'
import Components from 'unplugin-vue-components/vite'
import {BootstrapVueNextResolver} from 'bootstrap-vue-next/resolvers'

// https://vite.dev/config/
export default defineConfig({
  server: {
    proxy: {
      // Intercepts any request starting with /api
      '/api': {
        target: 'http://localhost:5000', // Your backend server URL
        changeOrigin: true,               // Changes the origin header to match the target
        secure: false,                   // Set to false if using self-signed SSL certs
        //rewrite: (path) => path.replace(/^\/api/, ''), // Strips '/api' from the forwarded request
      },
    },
  },
  plugins: [
    vue(),
    vueDevTools(),
    Components({
      resolvers: [BootstrapVueNextResolver()],
    }),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
    },
  },
})
