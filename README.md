# window_rounded_corners

Get Device Window Rounded Corners.


## Usage

### Add dependency

```yaml
dependencies:
  flutter:
    sdk: flutter
  # add window_rounded_corners
  window_rounded_corners: ^{latest version}
```


### Way 1

Only need to initialize once.

However, reading device information is asynchronous. using it immediately may get Corners.zero.

```dart
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

    WindowCorners.init();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('WindowCorners'),
        ),
        body: Center(child: Text("${WindowCorners.getCorners()}")),
      ),
    );
  }
}
```



### Way 2 
InheritedWidget data sharing.

Use ``WindowCornersProvider`` to listen data and automatically update Corners through ``WindowCornersData.of(context)``

```dart
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowCornersProvider(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('WindowCorners'),
          ),
          body: WindowCornersProviderBody(),
        ),
      ),
    );
  }  
}

class WindowCornersProviderBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("${WindowCornersData.of(context)?.corners}"));
  }
}
```
