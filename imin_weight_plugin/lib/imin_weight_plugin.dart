
// import 'package:flutter/services.dart';

// import 'imin_weight_plugin_platform_interface.dart';

// class IminWeightPlugin {
//   Future<String?> getPlatformVersion() {
//     return IminWeightPluginPlatform.instance.getPlatformVersion();
//   }
//   static const EventChannel _channel =
//     EventChannel('imin_scale/weight');

//    Stream<int> get weightStream =>
//     _channel.receiveBroadcastStream().cast<int>();


// }

import 'package:flutter/services.dart';

class IminWeightPlugin {
  static const EventChannel _channel =
      EventChannel('imin_scale/weight');

  static Stream<int> get weightStream =>
      _channel.receiveBroadcastStream().cast<int>();
}

