import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';

import '../stores/observable_alarm/observable_alarm.dart';

class MediaHandler {
  late AudioPlayer _currentPlayer;
  late double _originalVolume;

  changeVolume(ObservableAlarm alarm) async {
    _originalVolume = await PerfectVolumeControl.volume;
    PerfectVolumeControl.setVolume(alarm.volume);
  }

  getRandomPath(ObservableAlarm alarm) async {
    final FlutterAudioQuery query = FlutterAudioQuery();
    final allPlaylists = await query.getPlaylists() ?? [];

    final playlistSongIdChunks = allPlaylists
        .where((playlist) => alarm.playlistIds.contains(playlist.id))
        .map((info) => info.memberIds);

    var playlistSongIds;
    if (playlistSongIdChunks.length > 1)
      playlistSongIds = playlistSongIdChunks.reduce((a, b) => [...a!, ...b!]);
    else if (playlistSongIdChunks.length == 1)
      playlistSongIds = playlistSongIdChunks.toList()[0];
    else
      playlistSongIds = [];

    // Workaround for the case of a single playlist that has just one song
    // https://github.com/sc4v3ng3r/flutter_audio_query/issues/16
    // Adding hack after hack; good times
    final Iterable playlistPaths = playlistSongIds.length > 0
        ? (await query.getSongsById(ids: [...playlistSongIds, ""]))
            .map((info) => info.filePath)
        : [];

    final paths = [...alarm.musicPaths, ...playlistPaths];
    print('Paths: $paths');

    if (paths.isEmpty) {
      throw ArgumentError("Empty path array found");
    }

    final entry = Random().nextInt(paths.length);
    return paths[entry];
  }

  playMusicFromPath(String path, alarm) async {
    bool subscribed = false;
    _currentPlayer = AudioPlayer();

    late StreamSubscription subscription;
    subscription = _currentPlayer.onDurationChanged.listen((duration) {
      final seconds = duration.inSeconds;
      if (seconds < 30) {
        _currentPlayer.setReleaseMode(ReleaseMode.LOOP);
        subscription.cancel();
      } else {
        if (subscribed) return;
        _currentPlayer.onPlayerCompletion.listen((_) async {
          playMusic(alarm);
          subscription.cancel();
        });
        subscribed = true;
      }
    });

    final fixedPath = File(path).absolute.path;
    await _currentPlayer.setUrl(fixedPath, isLocal: true);
    _currentPlayer.play(fixedPath, isLocal: true, volume: 1.0);
  }

  playMusic(ObservableAlarm alarm) async {
    final path = await getRandomPath(alarm);
    playMusicFromPath(path, alarm);
  }

  stopAlarm() {
    PerfectVolumeControl.setVolume(_originalVolume);

    _currentPlayer.stop();
    _currentPlayer.release();
  }
}
