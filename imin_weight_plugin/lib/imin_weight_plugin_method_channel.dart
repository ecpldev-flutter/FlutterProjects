import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'imin_weight_plugin_platform_interface.dart';

/// An implementation of [IminWeightPluginPlatform] that uses method channels.
class MethodChannelIminWeightPlugin extends IminWeightPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('imin_weight_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
