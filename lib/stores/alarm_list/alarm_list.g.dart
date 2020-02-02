// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_list.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AlarmList on _AlarmList, Store {
  final _$alarmsAtom = Atom(name: '_AlarmList.alarms');

  @override
  ObservableList<ObservableAlarm> get alarms {
    _$alarmsAtom.context.enforceReadPolicy(_$alarmsAtom);
    _$alarmsAtom.reportObserved();
    return super.alarms;
  }

  @override
  set alarms(ObservableList<ObservableAlarm> value) {
    _$alarmsAtom.context.conditionallyRunInAction(() {
      super.alarms = value;
      _$alarmsAtom.reportChanged();
    }, _$alarmsAtom, name: '${_$alarmsAtom.name}_set');
  }

  final _$_AlarmListActionController = ActionController(name: '_AlarmList');

  @override
  void setAlarms(List<ObservableAlarm> alarms) {
    final _$actionInfo = _$_AlarmListActionController.startAction();
    try {
      return super.setAlarms(alarms);
    } finally {
      _$_AlarmListActionController.endAction(_$actionInfo);
    }
  }
}
