## Introduction

The `the_popup` package allows you to easily show a popup on your wrapped widget,
And you can easily customize its position wherever you want.

## Getting Started

To use this package, add `the_popup` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  the_popup: ^0.0.1
```

Alternatively, you can add it to your project by running the following commands in your terminal:

with Dart:

```shell
$ dart pub add the_popup
```

with Flutter:

```shell
$ flutter pub add the_popup
```

## Usage

To show a popup, wrap the widget that you want to display the popup on with the `InfoPopupWidget` widget. All you have to do is wrap it in the widget you want to show information with the `InfoPopupWidget` widget. With the `InfoPopupController`, you can customize it as you wish, and turn it on and off.

```dart
import 'package:the_popup/the_popup.dart';
```

```dart
    Popup(
      position: PopupPosition.bottomAlignCenter,
      barrierColor: Colors.black45,
      curve: Curves.fastLinearToSlowEaseIn,
      child: CustomPopup(),
    ).showAsDropDown(_popAnchorKey);
```

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/yalong0521/the_popup/blob/master/LICENSE "LICENSE") file for details.