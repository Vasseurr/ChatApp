import 'package:chat_app/product/view/chat_detail/binding/chat_detail_binding.dart';
import 'package:chat_app/product/view/chat_detail/ui/chat_detail_page.dart';
import 'package:chat_app/product/view/chats/binding/chats_binding.dart';
import 'package:chat_app/product/view/chats/ui/chats_page.dart';
import 'package:chat_app/product/view/create_chat_room/binding/create_chat_room_binding.dart';
import 'package:chat_app/product/view/create_chat_room/ui/create_chat_room_page.dart';
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
    GetPage(
        name: Routes.chats,
        page: () => ChatsPage(),
        binding: ChatsBinding(),
        transition: Transition.leftToRight,
        transitionDuration:
            const Duration(milliseconds: DurationConstants.lowMidDuration)),
    GetPage(
        name: Routes.chatDetail,
        page: () => ChatDetailPage(chatRoomModel: Get.arguments),
        binding: ChatDetailBinding(),
        transition: Transition.leftToRight,
        transitionDuration:
            const Duration(milliseconds: DurationConstants.lowMidDuration)),
    GetPage(
        name: Routes.createChatRoom,
        page: () => const CreateChatRoomPage(),
        binding: CreateChatRoomBinding(),
        transition: Transition.leftToRight,
        transitionDuration:
            const Duration(milliseconds: DurationConstants.lowMidDuration)),
  ];
}
