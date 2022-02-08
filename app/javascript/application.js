// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

import mrujs from "mrujs";
import CableReady from "cable_ready"
import { CableCar } from "mrujs/plugins"
import * as Turbo from "@hotwired/turbo"

// Fontawesome
import { config, library, dom } from '@fortawesome/fontawesome-svg-core'
// Change the config to fix the flicker
config.mutateApproach = 'sync'
// Import icons
import { faInfoCircle, faCheckCircle,
         faExclamationCircle, faExclamationTriangle,
         faExternalLinkAlt, faTimes,
         faBars, faAngleLeft } from '@fortawesome/free-solid-svg-icons'
import { faFacebook } from '@fortawesome/free-brands-svg-icons'
library.add(faInfoCircle, faCheckCircle,
            faExclamationCircle, faExclamationTriangle,
            faExternalLinkAlt, faTimes, faBars, faAngleLeft,
            faFacebook)
// Load icons
dom.watch()

window.Turbo = Turbo;

mrujs.start({
  plugins: [
    new CableCar(CableReady)
  ]
})
import "trix"
import "@rails/actiontext"
