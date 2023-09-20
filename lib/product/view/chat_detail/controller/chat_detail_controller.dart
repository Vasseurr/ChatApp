import 'dart:developer';

import 'package:chat_app/core/constants/duration_constants.dart';
import 'package:chat_app/core/extension/string_extension.dart';
import 'package:chat_app/core/socket/socket_manager.dart';
import 'package:chat_app/product/factory/user_factory.dart';
import 'package:chat_app/product/model/chat_room_model.dart';
import 'package:chat_app/product/model/message/create_message_model.dart';
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
      messageList.value = await _messageService.getAllMessages(roomId);
    } catch (e) {
      log("Get messages from room error $e");
    }
    changeLoading(false);
  }

  bool isSender(int index) =>
      messageList[index].sender?.id == UserFactory.user.id;

  //* if the two message which sent by same user, do not show profile image both of them
  bool isNextMessageSameUser(int index) {
    return messageList.length - 1 == index
        ? false
        : messageList[index].sender?.id == messageList[index + 1].sender?.id;
  }

  void addMessage(MessageModel model) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      messageList.add(model);
      if (duration != highDuration) {
        duration = highDuration;
      }
      scrollJump();
    });
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
        ..receiver = _chatRoomModel.users!.first
        ..content = textEditingController.text
        ..chatRoom = _chatRoomModel;
      SocketManager.instance.socket.emit("send_message", createMessageModel);
      textEditingController.text = "";
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
}
