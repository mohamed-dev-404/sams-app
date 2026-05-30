/// Platform-aware file saver.
/// Automatically resolves to the correct implementation at compile time:
///   - Web  → uses dart:html Blob + anchor click
///   - I/O  → uses path_provider + dart:io File
library;

export 'file_saver_stub.dart'
    if (dart.library.html) 'file_saver_web.dart'
    if (dart.library.io) 'file_saver_io.dart';
