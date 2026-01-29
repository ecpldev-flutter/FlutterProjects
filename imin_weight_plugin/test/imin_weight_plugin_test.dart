// import 'package:flutter_test/flutter_test.dart';
// import 'package:imin_weight_plugin/imin_weight_plugin.dart';
// import 'package:imin_weight_plugin/imin_weight_plugin_platform_interface.dart';
// import 'package:imin_weight_plugin/imin_weight_plugin_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockIminWeightPluginPlatform
//     with MockPlatformInterfaceMixin
//     implements IminWeightPluginPlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

// void main() {
//   final IminWeightPluginPlatform initialPlatform = IminWeightPluginPlatform.instance;

//   test('$MethodChannelIminWeightPlugin is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelIminWeightPlugin>());
//   });

//   test('getPlatformVersion', () async {
//     IminWeightPlugin iminWeightPlugin = IminWeightPlugin();
//     MockIminWeightPluginPlatform fakePlatform = MockIminWeightPluginPlatform();
//     IminWeightPluginPlatform.instance = fakePlatform;

//     expect(await iminWeightPlugin.getPlatformVersion(), '42');
//   });
// }
