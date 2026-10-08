{{flutter_js}}
{{flutter_build_config}}

// Make the compiled entrypoint URL unique for every Flutter Web build so a
// CDN cannot keep serving a previous app bundle after a deployment.
const cacheVersion = {{flutter_service_worker_version}};
for (const build of _flutter.buildConfig.builds) {
  if (build.mainJsPath) {
    build.mainJsPath += '?v=' + encodeURIComponent(cacheVersion);
  }
}

_flutter.loader.load();
