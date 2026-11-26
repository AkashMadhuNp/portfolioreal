// Picks the right store for the platform: browser localStorage on web,
// in-memory elsewhere.
export 'theme_store_stub.dart'
    if (dart.library.js_interop) 'theme_store_web.dart';
