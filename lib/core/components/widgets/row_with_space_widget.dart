import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RowWithSpacingWidget extends StatelessWidget {
  RowWithSpacingWidget(
      {Key? key,
      required this.children,
      required this.padding,
      this.crossAxisAlignment,
      this.mainAxisAlignment})
      : super(key: key);
  CrossAxisAlignment? crossAxisAlignment;
  MainAxisAlignment? mainAxisAlignment;
  EdgeInsetsGeometry padding;
  List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: children
          .map((child) => Padding(
                //  padding: EdgeInsets.only(right: space),
                padding: padding,
                child: child,
              ))
          .toList(),
    );
  }
}
