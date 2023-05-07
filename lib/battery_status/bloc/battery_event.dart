part of 'battery_bloc.dart';


class BatteryEvent {}

class BatteryStateChanged extends BatteryEvent{
  final int batteryPercentage;
  final BatteryPercentageFetchingStatus batteryPercentageFetchingStatus;
  final String error;

  BatteryStateChanged(
      {required this.batteryPercentage,
      required this.batteryPercentageFetchingStatus,
      required this.error});
}

class BatteryPercentageFetchingStarted extends BatteryEvent{}

class BatteryPercentageFetchingSucceeded extends BatteryEvent{
  final int batteryPercentage;
  final BatteryPercentageFetchingStatus batteryPercentageFetchingStatus;

  BatteryPercentageFetchingSucceeded(
      {required this.batteryPercentage, required this.batteryPercentageFetchingStatus});

}

class BatteryPercentageFetchingFailed extends BatteryEvent{
  final String error;

  BatteryPercentageFetchingFailed({required this.error});

}