import 'package:flutter/material.dart';
import 'package:the_popup/src/popup_container.dart';

import 'popup_position.dart';

class PopupRoute<T> extends ModalRoute<T> {
  final GlobalKey anchor;
  final PopupPosition position;
  final Color backgroundColor;
  final Curve curve;
  final Widget child;
  final Offset offset;

  PopupRoute({
    required this.anchor,
    required this.position,
    required this.backgroundColor,
    required this.curve,
    required this.child,
    required this.offset,
  });

  @override
  Color? get barrierColor => backgroundColor;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get opaque => false;

  @override
  bool get maintainState => true;

  @override
  bool get allowSnapshotting => false;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return PopupContainer(
      anchor: anchor,
      position: position,
      animation: CurvedAnimation(parent: animation, curve: curve),
      offset: offset,
      child: child,
    );
  }
}
