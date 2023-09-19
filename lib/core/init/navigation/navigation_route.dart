import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/duration_constants.dart';
import 'fade_in_route.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();

  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  Future<T?> to<T>(dynamic page,
      {dynamic arguments, Transition? transition}) async {
    return await Get.to<T>(page,
        arguments: arguments,
        transition: transition ?? Transition.rightToLeftWithFade,
        duration: const Duration(milliseconds: DurationConstants.lowDuration));
  }

  Future<T?> toNamed<T>(String name, {dynamic arguments}) async {
    return await Get.toNamed<T>(name, arguments: arguments);
  }

  Future<void> pushNamed(BuildContext context, String name, Widget page,
      {dynamic arguments, int? milliseconds}) async {
    /* return await navigatorKey.currentState!
        .pushNamed(name, arguments: arguments);*/
    await Navigator.push(context,
        FadeInRoute(page: page, routeName: name, milliseconds: milliseconds));
  }

  Future<void> pushReplacement(BuildContext context, String name, Widget page,
      {dynamic arguments, int? milliseconds}) async {
    await Navigator.pushReplacement(context,
        FadeInRoute(page: page, routeName: name, milliseconds: milliseconds));
  }

  Future<void> toReplacement(String name, {dynamic arguments}) async {
    await Get.offAndToNamed(name, arguments: arguments);
  }
}
