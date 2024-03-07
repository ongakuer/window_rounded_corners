import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'window_corners.dart';
import 'window_rounded_corners_method_channel.dart';

abstract class WindowRoundedCornersPlatform extends PlatformInterface {
  WindowRoundedCornersPlatform() : super(token: _token);

  static final Object _token = Object();

  static WindowRoundedCornersPlatform _instance =
      MethodChannelWindowRoundedCorners();

  static WindowRoundedCornersPlatform get instance => _instance;

  static set instance(WindowRoundedCornersPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Corners getCacheCorners() {
    throw UnimplementedError('getCacheCorners() has not been implemented.');
  }

  Future<Corners> queryCorners() {
    throw UnimplementedError('queryCorners() has not been implemented.');
  }
}
