import 'package:flutter/cupertino.dart';

class CustomPadding {
  static final CustomPadding _instance = CustomPadding._init();
  static CustomPadding get instance => _instance;

  CustomPadding._init();

  paddingAll({required double value}) => EdgeInsets.all(value);
  paddingSymmetric({double? horizontal, double? vertical}) =>
      EdgeInsets.symmetric(
          horizontal: horizontal ?? 0, vertical: vertical ?? 0);
  paddingOnly({double? top, double? left, double? right, double? bottom}) =>
      EdgeInsets.only(
        top: top ?? 0,
        left: left ?? 0,
        right: right ?? 0,
        bottom: bottom ?? 0,
      );
}
