import 'dart:developer';

import 'package:chat_app/core/constants/duration_constants.dart';
import 'package:chat_app/core/extension/string_extension.dart';
import 'package:chat_app/core/socket/socket_manager.dart';
import 'package:chat_app/product/factory/user_factory.dart';
import 'package:chat_app/product/model/chat_room_model.dart';
import 'package:chat_app/product/model/message/create_message_model.dart';
import 'package:chat_app/product/model/user_model.dart';
import 'package:chat_app/product/service/message_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../model/message_model.dart';

class ChatDetailController extends GetxController {
  final MessageService _messageService = MessageService.instance;

  RxBool isLoading = true.obs;
  void changeLoading(bool value) => isLoading.value = value;

  late ChatRoomModel _chatRoomModel;

  late String roomId;
  RxList<MessageModel> messageList = RxList();

  RxBool isEmptyText = true.obs;

  TextEditingController textEditingController = TextEditingController();
  ItemScrollController itemScrollController = ItemScrollController();
  Duration duration =
      const Duration(microseconds: DurationConstants.lowDuration);

  Duration highDuration =
      const Duration(milliseconds: DurationConstants.highDuration);

  void setChatRoomModel(ChatRoomModel chatRoomModel) =>
      _chatRoomModel = chatRoomModel;

  Future<void> callRoomMessages(String roomId) async {
    this.roomId = roomId;
    log("HHH ${this.roomId}");
    try {
      final List<MessageModel> list =
          await _messageService.getAllMessages(roomId);
      list.sort((a, b) => a.createdDate!.compareTo(b.createdDate!));
      messageList.value = list;
    } catch (e) {
      log("Get messages from room error $e");
    }
    changeLoading(false);
  }

  bool isSender(int index) =>
      index == -1 ? true : messageList[index].sender?.id == UserFactory.user.id;

  //* if the two message which sent by same user, do not show profile image both of them
  bool isNextMessageSameUser(int index) {
    return messageList.length - 1 == index
        ? false
        : messageList[index].sender?.id == messageList[index + 1].sender?.id;
  }

  String getRoomTitle(ChatRoomModel chatRoomModel) {
    if (chatRoomModel.users == null && chatRoomModel.users!.isEmpty) return "";
    String title = "";

    //* show two username unless length of the user list is bigger than 3 (2 + currentUser)
    if (chatRoomModel.users!.length > 3) {
      //* ${roomModel.users!.length - 2} means one username is showing (users.length - 1 - currentUser)
      //  return "${chatRoomModel.users!.first.userName.getValue()} and ${chatRoomModel.users!.length - 2} more";
      return "${_userFirstAndLastName(getReceiverModel(chatRoom: chatRoomModel))} and ${chatRoomModel.users!.length - 2} more";
    }
    for (var user in chatRoomModel.users!) {
      //* do not show current username and if the room has 2 user(current user and other), do not show any user in room title
      //if (user.userName.isNotNullOrEmpty() && user.id != UserFactory.user.id) {
      if (user.firstName.isNotNullOrEmpty() &&
          user.lastName.isNotNullOrEmpty() &&
          user.id != UserFactory.user.id) {
        // title += user.userName!;
        title += _userFirstAndLastName(user);
        //* check the index of user is last item (users.length - 1 - currentUser)
        if (chatRoomModel.users!.indexOf(user) !=
            chatRoomModel.users!.length - 1) {
          title += ", ";
        }
      }
    }
    return title;
  }

  void addMessage(MessageModel model) {
//    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    messageList.add(model);
    log("Length message list: " + messageList.length.toString());
    if (duration != highDuration) {
      duration = highDuration;
    }
    scrollJump();
    // });
    /*   messageList.add(model);
    if (duration != highDuration) {
      duration = highDuration;
    }*/
    // scrollJump();
  }

  void scrollJump() {
    //  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    if (messageList.isEmpty) return;
    itemScrollController.scrollTo(
        index: messageList.length - 1, duration: duration);
    // });
  }

  Future<void> sendMessage() async {
    if (textEditingController.text.isEmpty) return;
    try {
      CreateMessageModel createMessageModel = CreateMessageModel();

      createMessageModel
        ..sender = UserFactory.user
        ..receiver = getReceiverModel()
        ..content = textEditingController.text
        ..chatRoom = _chatRoomModel;
      SocketManager.instance.socket.emit("send_message", createMessageModel);
      textEditingController.text = "";
      isEmptyText.value = true;
      /*MessageModel response =
          await _messageService.saveMessage(createMessageModel);
      if (!response.id.isNotNullOrEmpty()) {
        textEditingController.text = "";
        addMessage(response);
      }*/
    } catch (e) {
      log("Send message exception $e");
    }
  }

  RxBool keyboardIsOpen(BuildContext context) =>
      (MediaQuery.of(context).viewInsets.bottom != 0).obs;

//* parameter needs when the page load first time and the _chatRoomModel is lazy
  UserModel getReceiverModel({ChatRoomModel? chatRoom}) {
    List<UserModel> list = chatRoom != null
        ? chatRoom.users!
            .skipWhile((user) => user.id == UserFactory.user.id)
            .toList()
        : _chatRoomModel.users!
            .skipWhile((user) => user.id == UserFactory.user.id)
            .toList();

    return list.isEmpty ? UserModel() : list.first;
  }

  void controlEmptyTextValue(String text) {
    log(text.toString());
    if (text.isNotEmpty && isEmptyText.value) {
      isEmptyText.value = false;
    } else if (text.isEmpty && !isEmptyText.value) {
      isEmptyText.value = true;
    }
  }

  String _userFirstAndLastName(UserModel userModel) {
    String temp = "";
    if (userModel.firstName.isNotNullOrEmpty()) {
      temp += userModel.firstName.toString().toCapitalize();
    }
    if (userModel.lastName.isNotNullOrEmpty()) {
      temp += " " + userModel.lastName.toString().toCapitalize();
    }
    return temp;
  }
}
