import 'package:flutter/material.dart';

import 'popup_position.dart';
import 'popup_route.dart' as route;

class Popup {
  final PopupPosition position;
  final Color barrierColor;
  final Curve curve;
  final Widget child;
  final Offset offset;

  Popup({
    this.position = PopupPosition.bottomAlignCenter,
    this.barrierColor = Colors.transparent,
    this.curve = Curves.easeInOut,
    this.offset = Offset.zero,
    required this.child,
  });

  Future<T?> showAsDropDown<T>(GlobalKey anchor) {
    assert(anchor.currentContext != null);
    return Navigator.push<T>(
      anchor.currentContext!,
      route.PopupRoute<T>(
        anchor: anchor,
        position: position,
        backgroundColor: barrierColor,
        curve: curve,
        offset: offset,
        child: child,
      ),
    );
  }
}
