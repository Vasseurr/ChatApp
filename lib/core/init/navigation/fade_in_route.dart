import 'package:flutter/material.dart';

import '../../constants/duration_constants.dart';

class FadeInRoute extends PageRouteBuilder {
  final Widget page;

  FadeInRoute(
      {required this.page,
      required String routeName,
      dynamic arguments,
      int? milliseconds})
      : super(
          settings: RouteSettings(
              name: routeName, arguments: arguments), // set name here
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
          transitionDuration: Duration(
              milliseconds: milliseconds ?? DurationConstants.lowDuration),
        );
}
