import 'package:chat_app/product/model/chat_room_model.dart';
import 'package:flutter/material.dart';

class ChatRoomCard extends StatelessWidget {
  ChatRoomCard({Key? key, required this.roomModel, required this.onTap})
      : super(key: key);

  ChatRoomModel roomModel;
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
      : roomModel.users!
          .map((e) =>
              roomModel.users?.indexOf(e) != (roomModel.users!.length - 1)
                  ? "${e.userName}, "
                  : "${e.userName}")
          .toString();
}
