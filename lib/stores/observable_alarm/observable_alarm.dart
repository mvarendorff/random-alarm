import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'observable_alarm.g.dart';

@JsonSerializable()
class ObservableAlarm extends ObservableAlarmBase with _$ObservableAlarm {
  ObservableAlarm(
      {name,
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
      active,
      musicPaths})
      : super(
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
            active: active,
            musicPaths: musicPaths);

  ObservableAlarm.dayList(
      name, hour, minute, volume, active, weekdays, musicPaths)
      : super(
            name: name,
            hour: hour,
            minute: minute,
            volume: volume,
            active: active,
            musicPaths: musicPaths,
            monday: weekdays[0],
            tuesday: weekdays[1],
            wednesday: weekdays[2],
            thursday: weekdays[3],
            friday: weekdays[4],
            saturday: weekdays[5],
            sunday: weekdays[6]);

  factory ObservableAlarm.fromJson(Map<String, dynamic> json) =>
      _$ObservableAlarmFromJson(json);

  Map<String, dynamic> toJson() => _$ObservableAlarmToJson(this);
}

abstract class ObservableAlarmBase with Store {
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

  /// Field holding the IDs of the soundfiles that should be loaded
  /// This is exclusively used for JSON serialization
  @_ObservableListJsonConverter()
  List<String> musicPaths;

  @observable
  @JsonKey(ignore: true)
  ObservableList<SongInfo> trackInfo = ObservableList();

  ObservableAlarmBase(
      {this.name,
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
      this.musicPaths});

  @action
  void removeItem(SongInfo info) {
    trackInfo.remove(info);
    trackInfo = trackInfo;
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
    if (musicPaths.length == 0) {
      trackInfo = ObservableList();
      return;
    }
    final songs = await FlutterAudioQuery().getSongsById(ids: musicPaths);
    trackInfo = ObservableList.of(songs);
  }

  updateMusicPaths() {
    musicPaths = trackInfo.map((info) => info.id).toList();
  }

}

class _ObservableListJsonConverter
    implements
        JsonConverter<ObservableList<ObservableAlarm>,
            List<Map<String, dynamic>>> {
  const _ObservableListJsonConverter();

  @override
  ObservableList<ObservableAlarm> fromJson(List<Map<String, dynamic>> json) =>
      ObservableList.of(json.map((map) => ObservableAlarm.fromJson(map)));

  @override
  List<Map<String, dynamic>> toJson(ObservableList<ObservableAlarm> list) =>
      list.map((alarm) => alarm.toJson()).toList();
}
