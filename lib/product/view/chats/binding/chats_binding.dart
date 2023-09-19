import 'package:chat_app/product/view/chats/controller/chats_controller.dart';
import 'package:get/get.dart';

class ChatsBinding implements Bindings {
  @override
  void dependencies() {
    return Get.lazyPut<ChatsController>(() => ChatsController());
  }
}
