import 'package:dear_diary/battery_status/bloc/battery_bloc.dart';
import 'package:dear_diary/shared/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BatteryStatus extends StatefulWidget {
  const BatteryStatus({Key? key}) : super(key: key);

  @override
  State<BatteryStatus> createState() => _BatteryStatusState();
}

class _BatteryStatusState extends State<BatteryStatus> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BatteryBloc, BatteryState>(
      builder: (context, state) {
        String batteryLevel = 'Unknown battery level.';
        if(state.batteryPercentageFetchingStatus==BatteryPercentageFetchingStatus.initial){
          return const Loading();
        }
        else if(state.batteryPercentageFetchingStatus==BatteryPercentageFetchingStatus.succeeded){
          batteryLevel = 'Battery percentage: ${state.batteryPercentage}';
        }else{
          batteryLevel = state.error;
        }
        return Text(
          batteryLevel,
          style: Theme
              .of(context)
              .textTheme
              .headlineSmall,
        );
      },
    );
  }
}
