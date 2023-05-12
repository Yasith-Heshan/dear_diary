import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dear_diary/repository/battery_repository.dart';
import 'package:equatable/equatable.dart';

part 'battery_state.dart';

class BatteryCubit extends Cubit<BatteryState> {
  final BatteryRepository _batteryRepository;
  late StreamSubscription _streamSubscription;
  BatteryCubit(this._batteryRepository)
      : super(const BatteryState(
            batteryPercentage: 0,
            batteryPercentageFetchingStatus:
                BatteryPercentageFetchingStatus.initial,
            error: '')){
    _streamSubscription = Stream.periodic(const Duration(minutes: 1)).listen(
            (event) => batteryPercentageFetchingStarted()
    );
  }
  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }

  Future<void> batteryPercentageFetchingStarted() async {
    final int batteryPercentage = await _batteryRepository.getBatteryLevel();
    if (batteryPercentage == -1) {
      batteryPercentageFetchingFailed(error: 'Unexpected Error');
    } else {
      batteryPercentageFetchingSucceeded(
          batteryPercentage: batteryPercentage,
          batteryPercentageFetchingStatus:
              BatteryPercentageFetchingStatus.succeeded);
    }
  }

  void batteryPercentageFetchingSucceeded(
      {required int batteryPercentage,
      required BatteryPercentageFetchingStatus
          batteryPercentageFetchingStatus}) {
    emit(BatteryState(
        error: '',
        batteryPercentage: batteryPercentage,
        batteryPercentageFetchingStatus:
            BatteryPercentageFetchingStatus.succeeded));
  }

  void batteryPercentageFetchingFailed({required String error}) {
    emit(BatteryState(
        error: error,
        batteryPercentage: 0,
        batteryPercentageFetchingStatus:
            BatteryPercentageFetchingStatus.failed));
  }
}
