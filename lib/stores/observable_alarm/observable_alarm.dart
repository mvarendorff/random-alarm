import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'observable_alarm.g.dart';

@JsonSerializable()
class ObservableAlarm extends ObservableAlarmBase with _$ObservableAlarm {
  ObservableAlarm(
      {id,
      name,
      hour,
      minute,
      monday,
      tuesday,
      wednesday,
      thursday,
      friday,
      saturday,
      sunday,
      volume,
      active})
      : super(
            id: id,
            name: name,
            hour: hour,
            minute: minute,
            monday: monday,
            tuesday: tuesday,
            wednesday: wednesday,
            thursday: thursday,
            friday: friday,
            saturday: saturday,
            sunday: sunday,
            volume: volume,
            active: active);

  ObservableAlarm.dayList(
      id, name, hour, minute, volume, active, weekdays, musicIds, musicPaths)
      : super(
            id: id,
            name: name,
            hour: hour,
            minute: minute,
            volume: volume,
            active: active,
            musicIds: musicIds,
            monday: weekdays[0],
            tuesday: weekdays[1],
            wednesday: weekdays[2],
            thursday: weekdays[3],
            friday: weekdays[4],
            saturday: weekdays[5],
            sunday: weekdays[6],
            musicPaths: musicPaths);

  factory ObservableAlarm.fromJson(Map<String, dynamic> json) =>
      _$ObservableAlarmFromJson(json);

  Map<String, dynamic> toJson() => _$ObservableAlarmToJson(this);
}

abstract class ObservableAlarmBase with Store {
  int id;

  @observable
  String name;

  @observable
  int hour;

  @observable
  int minute;

  @observable
  bool monday;

  @observable
  bool tuesday;

  @observable
  bool wednesday;

  @observable
  bool thursday;

  @observable
  bool friday;

  @observable
  bool saturday;

  @observable
  bool sunday;

  @observable
  double volume;

  @observable
  bool active;

  /// Field holding the IDs of the playlists that were added to the alarm
  /// This is used for JSON serialization as well as retrieving the music from
  /// the playlist when the alarm goes off
  List<String> playlistIds;

  /// Field holding the IDs of the soundfiles that should be loaded
  /// This is exclusively used for JSON serialization
  List<String> musicIds;

  /// Field holding the paths of the soundfiles that should be loaded.
  /// musicIds cannot be used in the alarm callback because of a weird
  /// interaction between flutter_audio_query and android_alarm_manager
  /// See Stack Overflow post here: https://stackoverflow.com/q/60203223/6707985
  List<String> musicPaths;

  @observable
  @JsonKey(ignore: true)
  ObservableList<SongInfo> trackInfo = ObservableList();

  @observable
  @JsonKey(ignore: true)
  ObservableList<PlaylistInfo> playlistInfo = ObservableList();

  ObservableAlarmBase(
      {this.id,
      this.name,
      this.hour,
      this.minute,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.sunday,
      this.volume,
      this.active,
      this.musicIds,
      this.musicPaths});

  @action
  void removeItem(SongInfo info) {
    trackInfo.remove(info);
    trackInfo = trackInfo;
  }

  @action
  void removePlaylist(PlaylistInfo info) {
    playlistInfo.remove(info);
    playlistInfo = playlistInfo;
  }

  @action
  void reorder(int oldIndex, int newIndex) {
    final path = trackInfo[oldIndex];
    trackInfo.removeAt(oldIndex);
    trackInfo.insert(newIndex, path);
    trackInfo = trackInfo;
  }

  @action
  loadTracks() async {
    if (musicIds.length == 0) {
      trackInfo = ObservableList();
      return;
    }

    // Workaround for https://github.com/sc4v3ng3r/flutter_audio_query/issues/16
    if (musicIds.length == 1) {
      musicIds.add("");
    }

    final songs = await FlutterAudioQuery().getSongsById(ids: musicIds);
    trackInfo = ObservableList.of(songs);
  }

  @action
  loadPlaylists() async {
    if (playlistIds.length == 0) {
      playlistInfo = ObservableList();
      return;
    }

    final playlists = await FlutterAudioQuery().getPlaylists();
    playlistInfo = ObservableList.of(
        playlists.where((info) => playlistIds.contains(info.id)));
  }

  updateMusicPaths() {
    musicIds = trackInfo.map((SongInfo info) => info.id).toList();
    musicPaths = trackInfo.map((SongInfo info) => info.filePath).toList();
    playlistIds = playlistInfo.map((info) => info.id).toList();
  }

  List<bool> get days {
    return [monday, tuesday, wednesday, thursday, friday, saturday, sunday];
  }

  // Good enough for debugging for now
  toString() {
    return "active: $active, music: $musicPaths";
  }
}
