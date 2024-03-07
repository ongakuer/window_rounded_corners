import 'dart:io';

import 'package:flutter/material.dart';

import 'window_corners.dart';
import 'window_rounded_corners_platform_interface.dart';

class WindowCornersProvider extends StatefulWidget {
  const WindowCornersProvider({super.key, required this.child});

  static GlobalKey<WindowCornersProviderState> globalKey = GlobalKey();

  final Widget child;

  @override
  State<StatefulWidget> createState() => WindowCornersProviderState();
}

class WindowCornersProviderState extends State<WindowCornersProvider> {
  Corners _corners = Corners.zero;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      _prepare();
    }
  }

  void _prepare() async {
    var corners = WindowRoundedCornersPlatform.instance.getCacheCorners();
    if (_corners != corners) {
      if (!mounted) return;
      setState(() {
        _corners = corners;
      });
      return;
    }
    corners = await WindowRoundedCornersPlatform.instance.queryCorners();
    if (_corners != corners) {
      if (!mounted) return;
      setState(() {
        _corners = corners;
      });
    }
  }

  void updateCorners(Corners? corners) {
    if (corners == null || _corners == corners) return;
    if (!mounted) return;
    setState(() {
      _corners = corners;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WindowCornersData(corners: _corners, child: widget.child);
  }
}

class WindowCornersData extends InheritedWidget {
  const WindowCornersData(
      {required this.corners, required super.child, super.key});

  final Corners corners;

  static WindowCornersData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<WindowCornersData>();
  }

  @override
  bool updateShouldNotify(WindowCornersData oldWidget) {
    return oldWidget.corners != corners;
  }
}
