// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'observable_alarm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObservableAlarm _$ObservableAlarmFromJson(Map<String, dynamic> json) {
  return ObservableAlarm(
    name: json['name'],
    hour: json['hour'],
    minute: json['minute'],
    monday: json['monday'],
    tuesday: json['tuesday'],
    wednesday: json['wednesday'],
    thursday: json['thursday'],
    friday: json['friday'],
    saturday: json['saturday'],
    sunday: json['sunday'],
    volume: json['volume'],
    active: json['active'],
    musicPaths: json['musicPaths'],
  );
}

Map<String, dynamic> _$ObservableAlarmToJson(ObservableAlarm instance) =>
    <String, dynamic>{
      'name': instance.name,
      'hour': instance.hour,
      'minute': instance.minute,
      'monday': instance.monday,
      'tuesday': instance.tuesday,
      'wednesday': instance.wednesday,
      'thursday': instance.thursday,
      'friday': instance.friday,
      'saturday': instance.saturday,
      'sunday': instance.sunday,
      'volume': instance.volume,
      'active': instance.active,
      'musicPaths': instance.musicPaths,
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ObservableAlarm on ObservableAlarmBase, Store {
  final _$nameAtom = Atom(name: 'ObservableAlarmBase.name');

  @override
  String get name {
    _$nameAtom.context.enforceReadPolicy(_$nameAtom);
    _$nameAtom.reportObserved();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.context.conditionallyRunInAction(() {
      super.name = value;
      _$nameAtom.reportChanged();
    }, _$nameAtom, name: '${_$nameAtom.name}_set');
  }

  final _$hourAtom = Atom(name: 'ObservableAlarmBase.hour');

  @override
  int get hour {
    _$hourAtom.context.enforceReadPolicy(_$hourAtom);
    _$hourAtom.reportObserved();
    return super.hour;
  }

  @override
  set hour(int value) {
    _$hourAtom.context.conditionallyRunInAction(() {
      super.hour = value;
      _$hourAtom.reportChanged();
    }, _$hourAtom, name: '${_$hourAtom.name}_set');
  }

  final _$minuteAtom = Atom(name: 'ObservableAlarmBase.minute');

  @override
  int get minute {
    _$minuteAtom.context.enforceReadPolicy(_$minuteAtom);
    _$minuteAtom.reportObserved();
    return super.minute;
  }

  @override
  set minute(int value) {
    _$minuteAtom.context.conditionallyRunInAction(() {
      super.minute = value;
      _$minuteAtom.reportChanged();
    }, _$minuteAtom, name: '${_$minuteAtom.name}_set');
  }

  final _$mondayAtom = Atom(name: 'ObservableAlarmBase.monday');

  @override
  bool get monday {
    _$mondayAtom.context.enforceReadPolicy(_$mondayAtom);
    _$mondayAtom.reportObserved();
    return super.monday;
  }

  @override
  set monday(bool value) {
    _$mondayAtom.context.conditionallyRunInAction(() {
      super.monday = value;
      _$mondayAtom.reportChanged();
    }, _$mondayAtom, name: '${_$mondayAtom.name}_set');
  }

  final _$tuesdayAtom = Atom(name: 'ObservableAlarmBase.tuesday');

  @override
  bool get tuesday {
    _$tuesdayAtom.context.enforceReadPolicy(_$tuesdayAtom);
    _$tuesdayAtom.reportObserved();
    return super.tuesday;
  }

  @override
  set tuesday(bool value) {
    _$tuesdayAtom.context.conditionallyRunInAction(() {
      super.tuesday = value;
      _$tuesdayAtom.reportChanged();
    }, _$tuesdayAtom, name: '${_$tuesdayAtom.name}_set');
  }

  final _$wednesdayAtom = Atom(name: 'ObservableAlarmBase.wednesday');

  @override
  bool get wednesday {
    _$wednesdayAtom.context.enforceReadPolicy(_$wednesdayAtom);
    _$wednesdayAtom.reportObserved();
    return super.wednesday;
  }

  @override
  set wednesday(bool value) {
    _$wednesdayAtom.context.conditionallyRunInAction(() {
      super.wednesday = value;
      _$wednesdayAtom.reportChanged();
    }, _$wednesdayAtom, name: '${_$wednesdayAtom.name}_set');
  }

  final _$thursdayAtom = Atom(name: 'ObservableAlarmBase.thursday');

  @override
  bool get thursday {
    _$thursdayAtom.context.enforceReadPolicy(_$thursdayAtom);
    _$thursdayAtom.reportObserved();
    return super.thursday;
  }

  @override
  set thursday(bool value) {
    _$thursdayAtom.context.conditionallyRunInAction(() {
      super.thursday = value;
      _$thursdayAtom.reportChanged();
    }, _$thursdayAtom, name: '${_$thursdayAtom.name}_set');
  }

  final _$fridayAtom = Atom(name: 'ObservableAlarmBase.friday');

  @override
  bool get friday {
    _$fridayAtom.context.enforceReadPolicy(_$fridayAtom);
    _$fridayAtom.reportObserved();
    return super.friday;
  }

  @override
  set friday(bool value) {
    _$fridayAtom.context.conditionallyRunInAction(() {
      super.friday = value;
      _$fridayAtom.reportChanged();
    }, _$fridayAtom, name: '${_$fridayAtom.name}_set');
  }

  final _$saturdayAtom = Atom(name: 'ObservableAlarmBase.saturday');

  @override
  bool get saturday {
    _$saturdayAtom.context.enforceReadPolicy(_$saturdayAtom);
    _$saturdayAtom.reportObserved();
    return super.saturday;
  }

  @override
  set saturday(bool value) {
    _$saturdayAtom.context.conditionallyRunInAction(() {
      super.saturday = value;
      _$saturdayAtom.reportChanged();
    }, _$saturdayAtom, name: '${_$saturdayAtom.name}_set');
  }

  final _$sundayAtom = Atom(name: 'ObservableAlarmBase.sunday');

  @override
  bool get sunday {
    _$sundayAtom.context.enforceReadPolicy(_$sundayAtom);
    _$sundayAtom.reportObserved();
    return super.sunday;
  }

  @override
  set sunday(bool value) {
    _$sundayAtom.context.conditionallyRunInAction(() {
      super.sunday = value;
      _$sundayAtom.reportChanged();
    }, _$sundayAtom, name: '${_$sundayAtom.name}_set');
  }

  final _$volumeAtom = Atom(name: 'ObservableAlarmBase.volume');

  @override
  double get volume {
    _$volumeAtom.context.enforceReadPolicy(_$volumeAtom);
    _$volumeAtom.reportObserved();
    return super.volume;
  }

  @override
  set volume(double value) {
    _$volumeAtom.context.conditionallyRunInAction(() {
      super.volume = value;
      _$volumeAtom.reportChanged();
    }, _$volumeAtom, name: '${_$volumeAtom.name}_set');
  }

  final _$activeAtom = Atom(name: 'ObservableAlarmBase.active');

  @override
  bool get active {
    _$activeAtom.context.enforceReadPolicy(_$activeAtom);
    _$activeAtom.reportObserved();
    return super.active;
  }

  @override
  set active(bool value) {
    _$activeAtom.context.conditionallyRunInAction(() {
      super.active = value;
      _$activeAtom.reportChanged();
    }, _$activeAtom, name: '${_$activeAtom.name}_set');
  }

  final _$musicPathsAtom = Atom(name: 'ObservableAlarmBase.musicPaths');

  @override
  ObservableList<String> get musicPaths {
    _$musicPathsAtom.context.enforceReadPolicy(_$musicPathsAtom);
    _$musicPathsAtom.reportObserved();
    return super.musicPaths;
  }

  @override
  set musicPaths(ObservableList<String> value) {
    _$musicPathsAtom.context.conditionallyRunInAction(() {
      super.musicPaths = value;
      _$musicPathsAtom.reportChanged();
    }, _$musicPathsAtom, name: '${_$musicPathsAtom.name}_set');
  }

  final _$ObservableAlarmBaseActionController =
      ActionController(name: 'ObservableAlarmBase');

  @override
  void removeItem(String musicPath) {
    final _$actionInfo = _$ObservableAlarmBaseActionController.startAction();
    try {
      return super.removeItem(musicPath);
    } finally {
      _$ObservableAlarmBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reorder(int oldIndex, int newIndex) {
    final _$actionInfo = _$ObservableAlarmBaseActionController.startAction();
    try {
      return super.reorder(oldIndex, newIndex);
    } finally {
      _$ObservableAlarmBaseActionController.endAction(_$actionInfo);
    }
  }
}
