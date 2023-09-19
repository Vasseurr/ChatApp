import 'package:flutter/material.dart';

import '../../constants/padding_values.dart';

class BaseWidget extends StatelessWidget {
  BaseWidget({Key? key, required this.child}) : super(key: key);

  Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: CustomPaddingValues.kdefaultPadding,
        left: CustomPaddingValues.mediumW,
        right: CustomPaddingValues.mediumW,
      ),
      child: child,
    );
  }
}
