import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_alarm/stores/alarm_status/alarm_status.dart';

class AlarmPollingWorker {
  void createPollingWorker() {
    poller(60).then((alarmId) {
      if (alarmId != null) {
        AlarmStatus().isAlarm = true;
        AlarmStatus().alarmId = int.parse(alarmId);
        cleanUpAlarmFiles();
      }
    });
  }

  /// Polling function checking for .alarm files in getApplicationDocumentsDirectory()
  /// every second for #iterations iterations.
  Future<String> poller(int iterations) async {
    for (int i = 0; i < iterations; i++) {
      final foundFiles = await findFiles();
      if (foundFiles.length > 0) return foundFiles[0];

      sleep(Duration(seconds: 1));
    }

    return null;
  }

  Future<List<String>> findFiles() async {
    final extension = ".alarm";
    final dir = await getApplicationDocumentsDirectory();
    return dir
        .list()
        .map((entry) => entry.path)
        .where((path) => path.endsWith(extension))
        .map((path) => basename(path))
        .map((path) => path.substring(0, path.length - extension.length))
        .toList();
  }

  void cleanUpAlarmFiles() async {
    final dir = await getApplicationDocumentsDirectory();
    dir
        .list()
        .where((entry) => entry.path.endsWith(".alarm"))
        .forEach((entry) => entry.delete());
  }
}
