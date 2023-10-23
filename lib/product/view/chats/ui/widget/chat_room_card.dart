import 'dart:developer';

import 'package:chat_app/core/components/widgets/custom_profile_image.dart';
import 'package:chat_app/core/extension/context_extension.dart';
import 'package:chat_app/core/extension/string_extension.dart';
import 'package:chat_app/product/factory/user_factory.dart';
import 'package:chat_app/product/model/chat_room_model.dart';
import 'package:flutter/material.dart';

import '../../../../../core/mixin/date_time_mixin.dart';

class ChatRoomCard extends StatelessWidget with DateTimeMixin {
  ChatRoomCard({Key? key, required this.roomModel, required this.onTap})
      : super(key: key);

  ChatRoomModel roomModel;
  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.getHeight * .005),
        child: ListTile(
          leading: CustomProfileImage(
            profilePhotoLink: roomModel.users?.first.photoLink,
          ),
          title: Text(
            getRoomTitle(),
            style: context.textTheme.bodyMedium,
          ),
          //  subtitle: _subTitle(),
          // subtitle: _subTitle(),
          trailing: Text(
            toMessageDate(roomModel.modifiedDate),
            style: context.textTheme.bodySmall?.apply(fontSizeFactor: 0.8),
          ),
        ),
      ),
    );
  }

  /* Widget _subTitle() => roomModel.users!.first.id == roomModel.users!.last.id
      ? const SizedBox()
      : Text(_showLastMessage());*/

  /*Widget _subTitle() => roomModel.users!.first.id == roomModel.users!.last.id
      ? const SizedBox()
      : Text(_getAllUsername());*/

  /*String _getAllUsername() {
    if (roomModel.users == null && roomModel.users!.isEmpty) return "";
    String subTitle = "";
    for (var user in roomModel.users!) {
      // do not show current username and if the room has 2 user(current user and other), do not show any user in subTitle
      if (user.userName.isNotNullOrEmpty() &&
          user.id != UserFactory.user.id &&
          user.id != roomModel.users!.first.id) {
        subTitle += user.userName!;
        // check the index of user is last item (users.length - 1 - currentUser)
        if (roomModel.users!.indexOf(user) != roomModel.users!.length - 2) {
          subTitle += ", ";
        }
      }
    }
    return subTitle;
  }*/

  String getRoomTitle() {
    if (roomModel.users == null && roomModel.users!.isEmpty) return "";
    String title = "";

    //* show two username unless length of the user list is bigger than 3 (2 + currentUser)
    if (roomModel.users!.length > 3) {
      //* ${roomModel.users!.length - 2} means one username is showing (users.length - 1 - currentUser)
      return "${roomModel.users!.first.userName.getValue()} and ${roomModel.users!.length - 2} more";
    }
    for (var user in roomModel.users!) {
      //* do not show current username and if the room has 2 user(current user and other), do not show any user in subTitle
      if (user.userName.isNotNullOrEmpty() && user.id != UserFactory.user.id) {
        title += user.userName!;
        //* check the index of user is last item (users.length - 1 - currentUser)
        if (roomModel.users!.indexOf(user) != roomModel.users!.length - 2) {
          title += ", ";
        }
      }
    }
    return title;
  }
}
