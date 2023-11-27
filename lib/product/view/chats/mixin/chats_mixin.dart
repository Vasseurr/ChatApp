import 'package:chat_app/product/view/chats/ui/chats_page.dart';
import 'package:flutter/material.dart';

mixin ChatsMixin on State<ChatsPage> {
  List<Color> chatRoomBackgroundColorList = [];
  List<Color> userCardBackgroundColor = [];

  @override
  void initState() {
    super.initState();
    chatRoomBackgroundColorList
        .addAll([Colors.grey.shade300, const Color.fromRGBO(238, 248, 254, 1)]);
    userCardBackgroundColor.addAll([
      Colors.pink,
      Colors.blueAccent.shade700,
      Colors.greenAccent.shade400,
      Colors.purpleAccent.shade700
    ]);
  }

  getChatRoomBackgroundColor(int index) =>
      chatRoomBackgroundColorList[index % chatRoomBackgroundColorList.length];
  getUserCardBackgroundColor(int index) =>
      userCardBackgroundColor[index % userCardBackgroundColor.length];
}
