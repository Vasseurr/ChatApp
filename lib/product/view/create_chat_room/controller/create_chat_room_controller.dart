import 'dart:developer';

import 'package:chat_app/core/components/utils/utils.dart';
import 'package:chat_app/core/extension/string_extension.dart';
import 'package:chat_app/core/init/navigation/navigation_route.dart';
import 'package:chat_app/product/factory/user_factory.dart';
import 'package:chat_app/product/model/chat_room/create_chat_room_model.dart';
import 'package:chat_app/product/model/chat_room_model.dart';
import 'package:chat_app/product/service/chat_room_service.dart';
import 'package:chat_app/product/service/user_service.dart';
import 'package:chat_app/product/view/chats/controller/chats_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../model/user_model.dart';

class CreateChatRoomController extends GetxController {
  final ChatRoomService _roomService = ChatRoomService.instance;
  final UserService _userService = UserService.instance;

  final RxBool isLoading = false.obs;
  changeLoading(bool value) => isLoading.value = value;

  final RxBool isInnerLoading = false.obs;
  changeInnerLoading(bool value) => isInnerLoading.value = value;

  final RxList<UserModel> userList = RxList();
  final RxList<UserModel> tempUserList = RxList();
  final RxList<UserModel> selectedUserList = RxList();

  final RxList<bool> selectedUserBoolList = RxList();
  final TextEditingController textEditingController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    await getAllUsers();
    tempUserList.value = userList.toList();
    selectedUserList.value = [];
    selectedUserBoolList.value =
        List.filled(userList.length, false, growable: false);
  }

  Future<void> getAllUsers() async {
    try {
      userList.value = await _userService.getAllUsers();
      userList.removeWhere((element) => element.id == UserFactory.user.id);
    } catch (e) {
      log("Get all users error $e");
    }
  }

  //*decide which operation will use
  void operate(UserModel user) {
    int index = userList.indexOf(user);
    if (selectedUserBoolList[index]) {
      unSelectUser(user);
      return;
    }
    addUser(user);
    return;
  }

  void addUser(UserModel user) {
    int index = userList.indexOf(user);
    selectedUserList.add(user);
    selectedUserBoolList[index] = true;
    textEditingController.clear();
    tempUserList.value = userList.toList();
  }

  void unSelectUser(UserModel user) {
    int index = userList.indexOf(user);
    selectedUserList.remove(user);
    selectedUserBoolList[index] = false;
  }

  bool getIsSelected(UserModel user) {
    return selectedUserBoolList[userList.indexOf(user)];
  }

  Future<void> createChatRoom() async {
    if (selectedUserList.isEmpty) return;
    try {
      changeInnerLoading(true);
      CreateChatRoomModel createChatRoomModel = CreateChatRoomModel();
      createChatRoomModel
        ..onlineUser = UserFactory.user
        ..users = selectedUserList.toList();
      //* adding online user
      // createChatRoomModel.users!.add(UserFactory.user);
      ChatRoomModel response =
          await _roomService.saveChatRoom(createChatRoomModel);
      inspect(response);
      if (response.id.isNotNullOrEmpty()) {
        if (response.createdBefore != null && !response.createdBefore!) {
          Get.find<ChatsController>().chatRoomList.insert(0, response);
          Utils.instance.showCustomSnackbar("Success", "Chatroom is creating",
              snackbarType: SnackbarType.success);
        }
        NavigationRoute.instance
            .toReplacement(Routes.chatDetail, arguments: response);
      }
    } catch (e) {
      log("Create chat room exception $e");
    }
    changeInnerLoading(false);
  }
}
