import 'package:flutter/material.dart';

import 'popup_position.dart';

class PopupContainer extends StatefulWidget {
  final GlobalKey anchor;
  final PopupPosition position;
  final Animation<double> animation;
  final WidgetBuilder childBuilder;
  final Offset offset;
  final VoidCallback? onShow;
  final VoidCallback? onDismiss;

  const PopupContainer({
    super.key,
    required this.anchor,
    required this.position,
    required this.animation,
    required this.childBuilder,
    required this.offset,
    this.onShow,
    this.onDismiss,
  });

  @override
  State<StatefulWidget> createState() {
    return _PopupState();
  }
}

class _PopupState extends State<PopupContainer>
    with SingleTickerProviderStateMixin {
  final _popKey = GlobalKey();
  double _left = 0, _top = 0;
  Offset _offset = Offset.zero;

  @override
  void initState() {
    super.initState();
    widget.animation.addListener(() {
      if (widget.animation.value == 0) {
        widget.onDismiss?.call();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onShow?.call();
      _calc();
      setState(() {});
    });
  }

  void _calc() {
    final anchorRenderObj = widget.anchor.currentContext?.findRenderObject();
    final popupRenderObj = _popKey.currentContext?.findRenderObject();
    if (anchorRenderObj == null || popupRenderObj == null) return;
    // Calculate the position of the popup.
    final anchorRenderBox = anchorRenderObj as RenderBox;
    final popupRenderBox = popupRenderObj as RenderBox;
    Offset anchorPosition = anchorRenderBox.localToGlobal(Offset.zero);
    anchorPosition += widget.offset;
    Size anchorSize = anchorRenderBox.size;
    Size popupSize = popupRenderBox.size;
    switch (widget.position) {
      case PopupPosition.leftAlignTop:
        _leftAlignTop(anchorPosition, anchorSize, popupSize);
        break;
      case PopupPosition.leftAlignCenter:
        _leftAlignCenter(anchorPosition, anchorSize, popupSize);
        break;
      case PopupPosition.leftAlignBottom:
        _leftAlignBottom(anchorPosition, anchorSize, popupSize);
        break;
      case PopupPosition.rightAlignTop:
        _rightAlignTop(anchorPosition, anchorSize, popupSize);
        break;
      case PopupPosition.rightAlignCenter:
        _rightAlignCenter(anchorPosition, anchorSize, popupSize);
        break;
      case PopupPosition.rightAlignBottom:
        _rightAlignBottom(anchorPosition, anchorSize, popupSize);
        break;
      case PopupPosition.topAlignLeft:
        _topAlignLeft(anchorPosition, anchorSize, popupSize);
        break;
      case PopupPosition.topAlignCenter:
        _topAlignCenter(anchorPosition, anchorSize, popupSize);
        break;
      case PopupPosition.topAlignRight:
        _topAlignRight(anchorPosition, anchorSize, popupSize);
        break;
      case PopupPosition.bottomAlignLeft:
        _bottomAlignLeft(anchorPosition, anchorSize, popupSize);
        break;
      case PopupPosition.bottomAlignCenter:
        _bottomAlignCenter(anchorPosition, anchorSize, popupSize);
        break;
      case PopupPosition.bottomAlignRight:
        _bottomAlignRight(anchorPosition, anchorSize, popupSize);
        break;
    }
  }

  void _leftAlignTop(Offset anchorPosition, Size anchorSize, Size popupSize) {
    _left = anchorPosition.dx - popupSize.width;
    _top = anchorPosition.dy;
    _offset = const Offset(1, 0);
  }

  void _leftAlignCenter(
      Offset anchorPosition, Size anchorSize, Size popupSize) {
    _left = anchorPosition.dx - popupSize.width;
    _top = anchorPosition.dy + anchorSize.height / 2 - popupSize.height / 2;
    _offset = const Offset(1, 0);
  }

  void _leftAlignBottom(
      Offset anchorPosition, Size anchorSize, Size popupSize) {
    _left = anchorPosition.dx - popupSize.width;
    _top = anchorPosition.dy + anchorSize.height - popupSize.height;
    _offset = const Offset(1, 0);
  }

  void _rightAlignTop(Offset anchorPosition, Size anchorSize, Size popupSize) {
    _left = anchorPosition.dx + anchorSize.width;
    _top = anchorPosition.dy;
    _offset = const Offset(-1, 0);
  }

  void _rightAlignCenter(
      Offset anchorPosition, Size anchorSize, Size popupSize) {
    _left = anchorPosition.dx + anchorSize.width;
    _top = anchorPosition.dy + anchorSize.height / 2 - popupSize.height / 2;
    _offset = const Offset(-1, 0);
  }

  void _rightAlignBottom(
      Offset anchorPosition, Size anchorSize, Size popupSize) {
    _left = anchorPosition.dx + anchorSize.width;
    _top = anchorPosition.dy + anchorSize.height - popupSize.height;
    _offset = const Offset(-1, 0);
  }

  void _topAlignLeft(Offset anchorPosition, Size anchorSize, Size popupSize) {
    _left = anchorPosition.dx;
    _top = anchorPosition.dy - popupSize.height;
    _offset = const Offset(0, 1);
  }

  void _topAlignCenter(Offset anchorPosition, Size anchorSize, Size popupSize) {
    _left = anchorPosition.dx + anchorSize.width / 2 - popupSize.width / 2;
    _top = anchorPosition.dy - popupSize.height;
    _offset = const Offset(0, 1);
  }

  void _topAlignRight(Offset anchorPosition, Size anchorSize, Size popupSize) {
    _left = anchorPosition.dx + anchorSize.width - popupSize.width;
    _top = anchorPosition.dy - popupSize.height;
    _offset = const Offset(0, 1);
  }

  void _bottomAlignLeft(
      Offset anchorPosition, Size anchorSize, Size popupSize) {
    _left = anchorPosition.dx;
    _top = anchorPosition.dy + anchorSize.height;
    _offset = const Offset(0, -1);
  }

  void _bottomAlignCenter(
      Offset anchorPosition, Size anchorSize, Size popupSize) {
    _left = anchorPosition.dx + anchorSize.width / 2 - popupSize.width / 2;
    _top = anchorPosition.dy + anchorSize.height;
    _offset = const Offset(0, -1);
  }

  void _bottomAlignRight(
      Offset anchorPosition, Size anchorSize, Size popupSize) {
    _left = anchorPosition.dx + anchorSize.width - popupSize.width;
    _top = anchorPosition.dy + anchorSize.height;
    _offset = const Offset(0, -1);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_popupWidget()]);
  }

  Widget _popupWidget() {
    _calc();
    var size = MediaQuery.of(context).size;
    var viewInsets = MediaQuery.of(context).viewInsets;
    var maxHeight = size.height - _top - viewInsets.bottom;
    size.width;
    Widget popupWidget = Container(
      key: _popKey,
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: widget.childBuilder(context),
    );
    if (_left == _top && _top == 0 && _offset == Offset.zero) {
      popupWidget = Offstage(offstage: true, child: popupWidget);
    } else {
      popupWidget = Positioned(
        left: _left,
        top: _top,
        child: ClipRect(
          child: SlideTransition(
            position: Tween<Offset>(
              begin: _offset,
              end: Offset.zero,
            ).animate(widget.animation),
            child: popupWidget,
          ),
        ),
      );
    }
    return popupWidget;
  }
}
