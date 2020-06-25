import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

class ErrorHandler {
  registerHandler() {
    FlutterError.onError = _errorLogger;
  }

  _errorLogger(FlutterErrorDetails details, {bool forceReport = true}) async {
    if (details == null) return;
    if (details.exception == null) return;

    final rendered = TextTreeRenderer(
            wrapWidth: 100,
            wrapWidthProperties: 100,
            maxDescendentsTruncatableNode: 5)
        .render(details.toDiagnosticsNode(style: DiagnosticsTreeStyle.error))
        .trimRight();

    debugPrint(rendered);

    final path = await getApplicationDocumentsDirectory();

    for (int i = 0; i < 100; i++) {
      final value = "log_$i.log";
      final file = File(path.path + value);
      final exists = await file.exists();

      if (exists) continue;

      final logFile = await file.create();
      logFile.writeAsString(rendered);
    }
  }
}
