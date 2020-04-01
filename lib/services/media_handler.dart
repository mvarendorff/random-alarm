import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:random_alarm/stores/observable_alarm/observable_alarm.dart';
import 'package:volume/volume.dart';

class MediaHandler {
  AudioPlayer _currentPlayer;
  int _originalVolume;

  changeVolume(ObservableAlarm alarm) async {
    _originalVolume = await Volume.getVol;
    final maxVolume = await Volume.getMaxVol;
    final newVolume = (maxVolume * alarm.volume).toInt();
    Volume.setVol(newVolume);
  }

  playMusic(ObservableAlarm alarm) {
    final paths = alarm.musicPaths;

    final entry = Random().nextInt(paths.length);
    final path = paths[entry];

    //If empty, get default ringtone
    //Pick a random path, pass it to the player; for testing just print it
    _currentPlayer = AudioPlayer();
    _currentPlayer.play(path, isLocal: true, volume: 1.0);
  }

  stopAlarm() {
    _currentPlayer.stop();
    Volume.setVol(_originalVolume);
  }
}