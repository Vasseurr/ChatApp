import 'dart:developer';

import 'package:chat_app/core/constants/duration_constants.dart';
import 'package:chat_app/product/factory/user_factory.dart';
import 'package:chat_app/product/service/message_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../model/message_model.dart';

class ChatDetailController extends GetxController {
  final MessageService _messageService = MessageService.instance;

  RxBool isLoading = true.obs;
  void changeLoading(bool value) => isLoading.value = value;

  late String roomId;
  RxList<MessageModel> messageList = RxList();

  final TextEditingController textEditingController = TextEditingController();
  final ItemScrollController itemScrollController = ItemScrollController();
  Duration duration =
      const Duration(microseconds: DurationConstants.lowDuration);

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

  void addMessage(MessageModel model) {
    messageList.add(model);
    duration = const Duration(milliseconds: DurationConstants.highDuration);
    scrollJump();
  }

  void scrollJump() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (messageList.isEmpty) return;
      itemScrollController.scrollTo(
          index: messageList.length - 1, duration: duration);
    });
  }
}
