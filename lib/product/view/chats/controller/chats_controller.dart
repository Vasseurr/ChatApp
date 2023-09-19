import 'dart:developer';

import 'package:chat_app/product/model/room_model.dart';
import 'package:chat_app/product/service/room_service.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController {
  final RoomService _roomService = RoomService.instance;

  RxBool isLoading = true.obs;
  void changeLoading(bool value) => isLoading.value = value;

  RxList<RoomModel> chatRoomList = RxList();

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
      chatRoomList.value = await _roomService.getAllRooms();
    } catch (e) {
      log("Get all chat rooms error $e");
    }
  }
}
