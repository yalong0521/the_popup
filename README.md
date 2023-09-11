## Introduction

The `the_popup` package allows you to easily show a popup on your wrapped widget,
And you can easily customize its position wherever you want.

## Getting Started

To use this package, add `the_popup` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  the_popup: ^0.0.3
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

```dart
import 'package:the_popup/the_popup.dart';
```

## Example

```dart
    Popup(
      position: PopupPosition.bottomAlignCenter,
      barrierColor: Colors.black45,
      curve: Curves.fastLinearToSlowEaseIn,
      child: CustomPopup(),
    ).showAsDropDown(anchorKey);
```

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/yalong0521/the_popup/blob/master/LICENSE "LICENSE") file for details.