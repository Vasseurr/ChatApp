import 'dart:developer';

import 'package:chat_app/product/factory/user_factory.dart';
import 'package:chat_app/product/model/chat_room_model.dart';
import 'package:chat_app/product/service/chat_room_service.dart';
import 'package:get/get.dart';

import '../../../model/user_model.dart';

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

  Future<void> _getAllChatRooms() async {
    try {
      final List<ChatRoomModel> list =
          await _roomService.getAllRoomsByUser(UserFactory.user.id);
      list.sort((a, b) => b.modifiedDate!.compareTo(a.modifiedDate!));
      chatRoomList.value = list;
    } catch (e) {
      log("Get all chat rooms error $e");
    }
  }

  UserModel getReceiverModel(ChatRoomModel chatRoomModel) {
    List<UserModel> list = chatRoomModel.users!
        .skipWhile((user) => user.id == UserFactory.user.id)
        .toList();

    return list.isEmpty ? UserModel() : list.first;
  }
}
