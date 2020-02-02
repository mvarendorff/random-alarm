import 'package:mobx/mobx.dart';
import 'package:json_annotation/json_annotation.dart';

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

  ObservableAlarm.dayList(name, hour, minute, volume, active, weekdays, musicPaths)
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

  @_ObservableListJsonConverter()
  @observable
  ObservableList<String> musicPaths;

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
  void removeItem(String musicPath) {
    musicPaths.remove(musicPath);
    musicPaths = musicPaths;
  }

  @action
  void reorder(int oldIndex, int newIndex) {
    final path = musicPaths[oldIndex];
    musicPaths.removeAt(oldIndex);
    musicPaths.insert(newIndex, path);
    musicPaths = musicPaths;
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
