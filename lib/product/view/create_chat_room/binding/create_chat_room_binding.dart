import 'package:chat_app/product/view/create_chat_room/controller/create_chat_room_controller.dart';
import 'package:get/get.dart';

class CreateChatRoomBinding implements Bindings {
  @override
  void dependencies() {
    return Get.lazyPut<CreateChatRoomController>(
        () => CreateChatRoomController());
  }
}
