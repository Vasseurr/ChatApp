import 'dart:developer';

import 'package:chat_app/core/components/text/custom_text_form_field.dart';
import 'package:chat_app/product/model/message_model.dart';
import 'package:chat_app/product/view/chat_detail/controller/chat_detail_controller.dart';
import 'package:chat_app/product/view/chat_detail/mixin/chat_detail_mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../core/constants/padding_values.dart';

class ChatDetailPage extends StatefulWidget {
  ChatDetailPage({Key? key, required this.roomId}) : super(key: key);

  String roomId;

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> with ChatDetailMixin {
  final ChatDetailController _chatDetailController =
      Get.find<ChatDetailController>();

/*
  @override
  void initState() {
    super.initState();
    _chatDetailController.callRoomMessages(widget.roomId);
    initSocket();
    _chatDetailController.scrollJump();

    /*  WidgetsBinding.instance.addPostFrameCallback((_) => {
           _chatDetailController.itemScrollController.to(
            0.0,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
          )
        });*/
  }

  

  @override
  void dispose() {
    _chatDetailController.textEditingController.dispose();
    socket.disconnect();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat detail")),
      body: Obx(
        () => _chatDetailController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : _body(),
      ),
    );
  }

  Padding _body() {
    return Padding(
      padding: EdgeInsets.only(top: CustomPaddingValues.mediumH),
      child: Column(
        children: [
          _list(),
          _sendMessage(),
        ],
      ),
    );
  }

  Expanded _list() {
    return Expanded(
        child: ScrollablePositionedList.builder(
      itemCount: _chatDetailController.messageList.length,
      itemBuilder: (context, index) => _message(context, index),
      itemScrollController: _chatDetailController.itemScrollController,
    ));
  }

  GestureDetector _message(BuildContext context, int index) {
    return GestureDetector(
      //onLongPress: () async => await _controller.deleteMessage(index),
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: _chatDetailController.isSender(index)
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                constraints: BoxConstraints(maxWidth: context.width * 0.7),
                decoration: BoxDecoration(
                  color: _chatDetailController.isSender(index)
                      ? Colors.green
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                      width: 1.0,
                      color: _chatDetailController.isSender(index)
                          ? Colors.green
                          : Colors.grey),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text(
                  _chatDetailController.messageList[index].content ?? "",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _sendMessage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTFF(
        textEditingController: _chatDetailController.textEditingController,
        radius: 50,
        //  hintTextColor: Colors.grey.shade800,
        //      hintText: LocaleKeys.feature_writeMessage.tr(),
        hintText: "send message",
        suffixIcon: IconButton(
          icon: const Icon(
            Icons.send,
            color: Colors.black,
          ),
          onPressed: (() => {}),
        ),
      ),
    );
  }
}
