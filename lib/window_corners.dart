import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:window_rounded_corners/window_rounded_corners_platform_interface.dart';

abstract class WindowCorners {
  static init() async {
    if (Platform.isAndroid) {
      WindowRoundedCornersPlatform.instance.queryCorners();
    }
  }

  static Corners getCorners() {
    if (Platform.isAndroid) {
      return WindowRoundedCornersPlatform.instance.getCacheCorners();
    } else {
      return Corners.zero;
    }
  }
}

@immutable
class Corners {
  final int topLeft;
  final int topRight;
  final int bottomRight;
  final int bottomLeft;

  const Corners(this.topLeft, this.topRight, this.bottomRight, this.bottomLeft);

  static const Corners zero = Corners(0, 0, 0, 0);

  static Corners fromMap(Map<String, int> map) =>
      Corners(map["tl"] ?? 0, map["tr"] ?? 0, map["br"] ?? 0, map["bl"] ?? 0);

  @override
  String toString() {
    return 'Corners{topLeft: $topLeft, topRight: $topRight, bottomRight: $bottomRight, bottomLeft: $bottomLeft}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Corners &&
          runtimeType == other.runtimeType &&
          topLeft == other.topLeft &&
          topRight == other.topRight &&
          bottomRight == other.bottomRight &&
          bottomLeft == other.bottomLeft;

  @override
  int get hashCode =>
      topLeft.hashCode ^
      topRight.hashCode ^
      bottomRight.hashCode ^
      bottomLeft.hashCode;
}
