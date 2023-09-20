import 'package:chat_app/product/view/create_chat_room/ui/create_chat_room_page.dart';
import 'package:flutter/material.dart';

import '../../../model/user_model.dart';
import '../controller/create_chat_room_controller.dart';

mixin CreateChatRoomMixin on State<CreateChatRoomPage> {
  filterSearchResults(
      {required CreateChatRoomController controller,
      required String searchingText}) {
    //controller.isSearching.value = true;
    List<UserModel> tempSearchList = [];
    tempSearchList.addAll(controller.tempUserList);
    if (searchingText.isNotEmpty) {
      List<UserModel> dummyListData = [];
      for (var item in tempSearchList) {
        if (item.userName!
            .toLowerCase()
            .contains(searchingText.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      controller.tempUserList.clear();
      controller.tempUserList.addAll(dummyListData);
      return;
    } else {
      controller.tempUserList.clear();
      controller.tempUserList.addAll(controller.userList);
      //   controller.isSearching.value = false;
    }
  }
}
