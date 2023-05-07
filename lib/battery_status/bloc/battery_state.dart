part of 'battery_bloc.dart';

enum BatteryPercentageFetchingStatus{
  initial,
  loading,
  succeeded,
  failed,
}
class BatteryState extends Equatable{
  final int batteryPercentage;
  final BatteryPercentageFetchingStatus batteryPercentageFetchingStatus;
  final String error;

  const BatteryState(
      {required this.error, required this.batteryPercentage,
        required this.batteryPercentageFetchingStatus
      });

  BatteryState copyWith(
  {
    required int batteryPercentage,
    required BatteryPercentageFetchingStatus batteryPercentageFetchingStatus
}
      ){
    return BatteryState(batteryPercentage: batteryPercentage, batteryPercentageFetchingStatus: batteryPercentageFetchingStatus, error: '');
  }

  @override
  // TODO: implement props
  List<Object?> get props => [batteryPercentage,batteryPercentageFetchingStatus,error];
}



