import 'dart:developer';

import 'package:chat_app/product/model/chat_room_model.dart';
import 'package:chat_app/product/service/chat_room_service.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController {
  final ChatRoomService _roomService = ChatRoomService.instance;

  RxBool isLoading = true.obs;
  void changeLoading(bool value) => isLoading.value = value;

  RxList<ChatRoomModel> chatRoomList = RxList();

  @override
  Future<void> onInit() async {
    super.onInit();
    await _getAllChatRooms();
    changeLoading(false);
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> _getAllChatRooms() async {
    try {
      final List<ChatRoomModel> list = await _roomService.getAllRooms();
      list.sort((a, b) => b.modifiedDate!.compareTo(a.modifiedDate!));
      chatRoomList.value = list;
    } catch (e) {
      log("Get all chat rooms error $e");
    }
  }
}
