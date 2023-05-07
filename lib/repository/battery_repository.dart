import 'package:flutter/services.dart';

class BatteryRepository {
  static const platform = MethodChannel('samples.flutter.dev/battery');

  Future<int> getBatteryLevel() async {
    int batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = result;
      // batteryLevel = 'Battery Percentage: $result %';
    } on PlatformException catch (e) {
      // batteryLevel = "Failed to get battery level: '${e.message}'.";
      batteryLevel = -1;
    }
    return batteryLevel;
  }
}
