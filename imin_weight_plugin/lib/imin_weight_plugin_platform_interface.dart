import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'imin_weight_plugin_method_channel.dart';

abstract class IminWeightPluginPlatform extends PlatformInterface {
  /// Constructs a IminWeightPluginPlatform.
  IminWeightPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static IminWeightPluginPlatform _instance = MethodChannelIminWeightPlugin();

  /// The default instance of [IminWeightPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelIminWeightPlugin].
  static IminWeightPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [IminWeightPluginPlatform] when
  /// they register themselves.
  static set instance(IminWeightPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
