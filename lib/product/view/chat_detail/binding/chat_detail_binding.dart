import 'package:chat_app/product/view/chat_detail/controller/chat_detail_controller.dart';
import 'package:get/get.dart';

class ChatDetailBinding implements Bindings {
  @override
  void dependencies() {
    return Get.lazyPut<ChatDetailController>(() => ChatDetailController());
  }
}
