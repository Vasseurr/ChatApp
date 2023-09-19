import 'package:get/get.dart';
import '../../core/routes/app_routes.dart';
import '../../product/view/intro_page.dart';
import '../constants/duration_constants.dart';

class AppPages {
  AppPages._();

  static final pages = [
    GetPage(
        name: Routes.initial,
        page: () => const IntroPage(),
        transition: Transition.fadeIn,
        transitionDuration:
            const Duration(milliseconds: DurationConstants.lowMidDuration)),
  ];
}
