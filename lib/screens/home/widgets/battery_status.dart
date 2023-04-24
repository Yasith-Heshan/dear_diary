import 'dart:async';
import 'package:dear_diary/services/battery_service.dart';
import 'package:flutter/material.dart';

class BatteryStatus extends StatefulWidget {
  const BatteryStatus({Key? key}) : super(key: key);

  @override
  State<BatteryStatus> createState() => _BatteryStatusState();
}

class _BatteryStatusState extends State<BatteryStatus> {
  String _batteryLevel = 'Unknown battery level.';
  Future<void> updateBatteryLevel()async {
    String batteryLevel = await BatteryService().getBatteryLevel();
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
  @override
  Widget build(BuildContext context) {
    updateBatteryLevel();
    return Text(
              _batteryLevel,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 20
            ),
          );
  }
}
