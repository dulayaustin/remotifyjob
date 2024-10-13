// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";
import "./controllers";
import mrujs from "mrujs";

import "trix";
import "@rails/actiontext";

mrujs.start();
