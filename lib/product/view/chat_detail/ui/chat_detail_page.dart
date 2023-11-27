import 'dart:developer';

import 'package:chat_app/core/components/text/custom_text_form_field.dart';
import 'package:chat_app/core/components/widgets/custom_profile_image.dart';
import 'package:chat_app/core/constants/app_constants.dart';
import 'package:chat_app/core/extension/context_extension.dart';
import 'package:chat_app/core/extension/widget_extension.dart';
import 'package:chat_app/product/model/chat_room_model.dart';
import 'package:chat_app/product/view/chat_detail/controller/chat_detail_controller.dart';
import 'package:chat_app/product/view/chat_detail/mixin/chat_detail_mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide ContextExtensionss;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../core/constants/padding_values.dart';

class ChatDetailPage extends StatefulWidget {
  ChatDetailPage({Key? key, required this.chatRoomModel}) : super(key: key);

  ChatRoomModel chatRoomModel;

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
      appBar: AppBar(
          title: Row(
        children: [
          const Spacer(),
          Text(_chatDetailController.getRoomTitle(widget.chatRoomModel),
              style: context.textTheme.titleMedium),
          context.spaceWidth(context.getWidth * .03),
          CustomProfileImage(
              profilePhotoLink: _chatDetailController
                  .getReceiverModel(chatRoom: widget.chatRoomModel)
                  .photoLink),
        ],
      )),
      body: Obx(
        () => _chatDetailController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : _body(),
      ),
    );
  }

  Container _body() {
    return Container(
      color: Colors.grey.shade100,
      padding: EdgeInsets.only(top: CustomPaddingValues.mediumH),
      child: Column(
        children: [
          _list(),
          _bottomBox(),
        ],
      ),
    );
  }

  Expanded _list() {
    return Expanded(
        child: _chatDetailController.messageList.isEmpty
            ? const SizedBox.shrink()
            : ScrollablePositionedList.builder(
                itemCount: _chatDetailController.messageList.length,
                itemBuilder: (context, index) => _message(context, index),
                itemScrollController:
                    _chatDetailController.itemScrollController,
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
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  _profilePhotoOrEmptyBox(index, false),
                  Container(
                    constraints:
                        BoxConstraints(maxWidth: context.getWidth * 0.7),
                    decoration: BoxDecoration(
                      color: _chatDetailController.isSender(index)
                          ? Colors.green
                          : Colors.grey,
                      borderRadius:
                          BorderRadius.circular(AppConstants.lowRadius),
                      border: Border.all(
                          width: 1.0,
                          color: _chatDetailController.isSender(index)
                              ? Colors.green
                              : Colors.grey),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Text(
                      _chatDetailController.messageList[index].content ?? "",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  _profilePhotoOrEmptyBox(index, true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profilePhotoOrEmptyBox(int index, bool isWidgetAlignRight) {
    return isWidgetAlignRight
        ? _chatDetailController.isSender(index) &&
                !_chatDetailController.isNextMessageSameUser(index)
            ? _customPImage(index)
            : const SizedBox()
        : !_chatDetailController.isSender(index) &&
                !_chatDetailController.isNextMessageSameUser(index)
            ? _customPImage(index)
            : const SizedBox();
  }

  CustomProfileImage _customPImage(int index) {
    return CustomProfileImage(
        profilePhotoLink:
            _chatDetailController.messageList[index].sender?.photoLink);
  }

  Container _bottomBox() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.midRadius)),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 10,
              child: _sendMessage(),
            ),
            context.spaceWidth(context.getWidth * .02),
            _chatDetailController.isEmptyText.value
                ? _greenButton(Icons.mic_rounded, () {
                    log("message");
                  })
                : _greenButton(
                    Icons.send_rounded,
                    (() async => {
                          FocusScope.of(context).unfocus(),
                          await _chatDetailController.sendMessage()
                        }),
                  )
          ],
        ),
      ),
    );
  }

  CustomTFF _sendMessage() {
    return CustomTFF(
      textEditingController: _chatDetailController.textEditingController,
      radius: AppConstants.lowRadius,
      borderColor: Colors.grey.shade300,
      //  hintTextColor: Colors.grey.shade800,
      //      hintText: LocaleKeys.feature_writeMessage.tr(),
      hintText: "Type a message",
      hintColor: Colors.grey,
      suffixIcon: IconButton(
        icon: Icon(
          _chatDetailController.keyboardIsOpen(context).value
              ? Icons.send
              : Icons.camera_alt_rounded,
          //Icons.camera_alt_rounded,
          color: Colors.grey,
        ),
        onPressed: (() async => {
              FocusScope.of(context).unfocus(),
              await _chatDetailController.sendMessage()
            }),
      ),
      onChanged: (text) => _chatDetailController.controlEmptyTextValue(text),
    );
  }

  InkWell _greenButton(IconData iconData, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration:
            const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
        child: Icon(
          iconData,
          color: Colors.white,
        ),
      ),
    );
  }
}
