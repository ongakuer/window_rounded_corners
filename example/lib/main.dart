import 'package:flutter/material.dart';
import 'package:window_rounded_corners/window_corners.dart';
import 'package:window_rounded_corners/window_corners_provider.dart';

void main() {
  runApp(const WindowCornersProviderDemo());
}

// void main() {
//   runApp(const WindowCornersApp());
// }

/// Use WindowCornersProvider + WindowCornersData.of(context)
class WindowCornersProviderDemo extends StatelessWidget {
  const WindowCornersProviderDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowCornersProvider(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('WindowCorners'),
          ),
          body: _WindowCornersProviderBody(),
        ),
      ),
    );
  }
}

class _WindowCornersProviderBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Text('WindowCorners\n${WindowCornersData.of(context)?.corners}'),
      ),
    );
  }
}

/// Use WindowCorners
class WindowCornersApp extends StatelessWidget {
  const WindowCornersApp({super.key});

  @override
  Widget build(BuildContext context) {
    WindowCorners.init();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('WindowCorners'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Text('WindowCorners\n${WindowCorners.getCorners()}'),
          ),
        ),
      ),
    );
  }
}
