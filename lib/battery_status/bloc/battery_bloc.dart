import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dear_diary/repository/battery_repository.dart';
import 'package:equatable/equatable.dart';

part 'battery_event.dart';
part 'battery_state.dart';

class BatteryBloc extends Bloc<BatteryEvent, BatteryState> {
  final BatteryRepository _batteryRepository;
  late StreamSubscription _streamSubscription;

  BatteryBloc(this._batteryRepository) : super(const BatteryState(
      batteryPercentage: 0,
      batteryPercentageFetchingStatus: BatteryPercentageFetchingStatus.initial,
      error: '')) {
    on<BatteryPercentageFetchingStarted>(_onBatteryPercentageFetchingStart);
    on<BatteryPercentageFetchingFailed>(_onBatteryPercentageFetchingFailed);
    on<BatteryPercentageFetchingSucceeded>(_onBatteryPercentageFetchingSucceeded);
    _streamSubscription = Stream.periodic(const Duration(minutes: 1)).listen(
            (event) => add(BatteryPercentageFetchingStarted())
    );
  }


  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }


  Future<void> _onBatteryPercentageFetchingStart(
      BatteryPercentageFetchingStarted event,
      Emitter<BatteryState> emit) async {
    final int batteryPercentage = await _batteryRepository.getBatteryLevel();
    if(batteryPercentage==-1){
      add(BatteryPercentageFetchingFailed(error: 'Unexpected Error'));
    }else{
      add(BatteryPercentageFetchingSucceeded(batteryPercentage: batteryPercentage, batteryPercentageFetchingStatus: BatteryPercentageFetchingStatus.succeeded));
    }
  }

  void _onBatteryPercentageFetchingSucceeded(
      BatteryPercentageFetchingSucceeded event,
      Emitter<BatteryState> emit
      ){
    emit(BatteryState(error: '', batteryPercentage: event.batteryPercentage, batteryPercentageFetchingStatus: BatteryPercentageFetchingStatus.succeeded));
  }

  void _onBatteryPercentageFetchingFailed(
      BatteryPercentageFetchingFailed event,
      Emitter<BatteryState> emit
      ){
    emit(BatteryState(error: event.error, batteryPercentage: 0, batteryPercentageFetchingStatus: BatteryPercentageFetchingStatus.failed));
  }

}

