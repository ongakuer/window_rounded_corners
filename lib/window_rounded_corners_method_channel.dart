import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:window_rounded_corners/window_corners.dart';
import 'package:window_rounded_corners/window_corners_provider.dart';
import 'package:window_rounded_corners/window_rounded_corners_platform_interface.dart';

class MethodChannelWindowRoundedCorners extends WindowRoundedCornersPlatform {
  @visibleForTesting
  final methodChannel = const OptionalMethodChannel(
      'me.relex.flutter.plugin.window_rounded_corners');

  Corners _corners = Corners.zero;

  MethodChannelWindowRoundedCorners() {
    methodChannel.setMethodCallHandler(handler);
  }

  Future<void> handler(MethodCall call) async {
    switch (call.method) {
      case "updateWindowCorners":
        {
          final map = call.arguments as Map<String, int>;
          _corners = Corners.fromMap(map);
          var state = WindowCornersProvider.globalKey.currentState;
          if (state != null) {
            state.updateCorners(_corners);
          }
          // log.e(
          //     "MethodChannelWindowRoundedCorners updateWindowCorners $_corners, state = $state");
          break;
        }
    }
    return Future.value(null);
  }

  @override
  Future<Corners> queryCorners() async {
    try {
      Map<String, int>? result =
          await methodChannel.invokeMapMethod<String, int>("getWindowCorners");
      if (result != null) {
        _corners = Corners.fromMap(result);
        // log.e(
        //     "MethodChannelWindowRoundedCorners queryWindowCorners $_corners");
      } else {
        // ignored
      }
    } catch (e) {
      // ignored
    }
    return Future.value(_corners);
  }

  @override
  Corners getCacheCorners() => _corners;
}
