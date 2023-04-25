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
  int _currentBatteryLevel = -1;
  Future<void> updateBatteryLevel() async {
    int batteryLevel = await BatteryService().getBatteryLevel();
    if (batteryLevel == -1) {
      _batteryLevel = 'Failed to update battery level';
    } else if (_currentBatteryLevel != batteryLevel) {
      setState(() {
        _currentBatteryLevel = batteryLevel;
        _batteryLevel = 'Battery Percentage: $_currentBatteryLevel';
      });
    }
  }

  @override
  initState() {
    super.initState();
    updateBatteryLevel();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _batteryLevel,
      style: const TextStyle(color: Colors.white54, fontSize: 20),
    );
  }
}
