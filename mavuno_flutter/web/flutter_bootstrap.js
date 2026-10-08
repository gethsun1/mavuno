{{flutter_js}}
{{flutter_build_config}}

// Make the compiled entrypoint URL unique for every Flutter Web build so a
// CDN cannot keep serving a previous app bundle after a deployment.
for (const build of _flutter.buildConfig.builds) {
  if (build.mainJsPath) {
    build.mainJsPath += '?v={{flutter_service_worker_version}}';
  }
}

_flutter.loader.load();
