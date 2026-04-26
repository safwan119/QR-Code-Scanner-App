import 'package:flutter/cupertino.dart';
import 'package:wifi_iot/wifi_iot.dart';

class WifiLaunch {
  static Future<void> launchToWifi({required String wifiName}) async {
    final parts = wifiName.split(';');
    String ssid = parts[0].split(':').last;
    String password = parts[2].split(':').last;
    await WiFiForIoTPlugin.setEnabled(true);
    await WiFiForIoTPlugin.forceWifiUsage(true);
    bool isConnected = await WiFiForIoTPlugin.connect(
      ssid,
      password: password,
      security: NetworkSecurity.WPA,
    );
    debugPrint(isConnected ? "Connected!" : "Failed to connect");
    if (!isConnected) {
      debugPrint("Opening WiFi settings...");
      await WiFiForIoTPlugin.setEnabled(true);
    }
  }
}
