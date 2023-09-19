import 'package:chat_app/product/model/room_model.dart';
import 'package:flutter/material.dart';

class ChatRoomCard extends StatelessWidget {
  ChatRoomCard({Key? key, required this.roomModel, required this.onTap})
      : super(key: key);

  RoomModel roomModel;
  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(getRoomTitle()),
        ),
      ),
    );
  }

  String getRoomTitle() => roomModel.users == null
      ? ""
      : roomModel.users!.map((e) => "${e.userName}, ").toString();
}
