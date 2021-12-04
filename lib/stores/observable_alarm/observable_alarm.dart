import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'observable_alarm.g.dart';

@JsonSerializable()
class ObservableAlarm extends GetxController {
  int id;

  String name;

  int hour;

  int minute;

  bool monday;

  bool tuesday;

  bool wednesday;

  bool thursday;

  bool friday;

  bool saturday;

  bool sunday;

  double volume;

  bool active;

  /// Field holding the IDs of the playlists that were added to the alarm
  /// This is used for JSON serialization as well as retrieving the music from
  /// the playlist when the alarm goes off
  List<String> playlistIds = [];

  /// Field holding the IDs of the soundfiles that should be loaded
  /// This is exclusively used for JSON serialization
  List<String> musicIds;

  /// Field holding the paths of the soundfiles that should be loaded.
  /// musicIds cannot be used in the alarm callback because of a weird
  /// interaction between flutter_audio_query and android_alarm_manager
  /// See Stack Overflow post here: https://stackoverflow.com/q/60203223/6707985
  List<String> musicPaths;

  @JsonKey(ignore: true)
  List<SongInfo> trackInfo = [];

  @JsonKey(ignore: true)
  List<PlaylistInfo> playlistInfo = [];

  ObservableAlarm(
      {required this.id,
      required this.name,
      required this.hour,
      required this.minute,
      required this.monday,
      required this.tuesday,
      required this.wednesday,
      required this.thursday,
      required this.friday,
      required this.saturday,
      required this.sunday,
      required this.volume,
      required this.active,
      required this.musicIds,
      required this.musicPaths});

  ObservableAlarm.dayList(
    this.id,
    this.name,
    this.hour,
    this.minute,
    this.volume,
    this.active,
    weekdays,
    this.musicIds,
    this.musicPaths,
  )   : monday = weekdays[0].obs,
        tuesday = weekdays[1].obs,
        wednesday = weekdays[2].obs,
        thursday = weekdays[3].obs,
        friday = weekdays[4].obs,
        saturday = weekdays[5].obs,
        sunday = weekdays[6].obs;

  void removeItem(SongInfo info) {
    trackInfo.remove(info);
  }

  void removePlaylist(PlaylistInfo info) {
    playlistInfo.remove(info);
  }

  void reorder(int oldIndex, int newIndex) {
    final path = trackInfo[oldIndex];
    trackInfo.removeAt(oldIndex);
    trackInfo.insert(newIndex, path);
    trackInfo = trackInfo;
  }

  Future<void> loadTracks() async {
    if (musicIds.length == 0) {
      trackInfo = [];
      return;
    }

    // Workaround for https://github.com/sc4v3ng3r/flutter_audio_query/issues/16
    if (musicIds.length == 1) {
      musicIds.add("");
    }

    final songs = await FlutterAudioQuery().getSongsById(ids: musicIds);
    trackInfo = songs;
  }

  Future<void> loadPlaylists() async {
    if (playlistIds.length == 0) {
      playlistInfo = [];
      return;
    }

    final playlists = await FlutterAudioQuery().getPlaylists() ?? [];

    final selectedPlaylists = playlists
        .whereType<PlaylistInfo>()
        .where((info) => playlistIds.contains(info.id))
        .toList();

    playlistInfo = selectedPlaylists;
  }

  updateMusicPaths() {
    musicIds = trackInfo.map((SongInfo info) => info.id).toList();
    musicPaths = trackInfo
        .map((SongInfo info) => info.filePath)
        .whereType<String>()
        .toList();
    playlistIds = playlistInfo.map((info) => info.id).toList();
  }

  List<bool> get days {
    return [monday, tuesday, wednesday, thursday, friday, saturday, sunday];
  }

  // Good enough for debugging for now
  toString() {
    return "active: $active, music: $musicPaths";
  }

  factory ObservableAlarm.fromJson(Map<String, dynamic> json) =>
      _$ObservableAlarmFromJson(json);

  Map<String, dynamic> toJson() => _$ObservableAlarmToJson(this);
}
