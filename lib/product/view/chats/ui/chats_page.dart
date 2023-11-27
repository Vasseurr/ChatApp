import 'package:chat_app/core/extension/context_extension.dart';
import 'package:chat_app/core/init/navigation/navigation_route.dart';
import 'package:chat_app/product/view/chats/controller/chats_controller.dart';
import 'package:chat_app/product/view/chats/mixin/chats_mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide ContextExtensionss;

import '../../../../core/constants/app_constants.dart';
import '../../../../core/routes/app_routes.dart';
import 'widget/chat_room_card.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> with ChatsMixin {
  final ChatsController _chatsController = Get.find<ChatsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text(
          "Chats",
          style: context.textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () =>
                NavigationRoute.instance.toNamed(Routes.createChatRoom)
                    //* for refresh list
                    .then(
              (value) {
                /*ChatRoomsPage().textEditingController.clear();
                    Get.find<MessagesController>().tempUserList.value =
                        Get.find<MessagesController>().userList.toList();*/
              },
            ),
            icon: const Icon(
              Icons.add,
              size: AppConstants.midRadius,
            ),
          )
        ],
      ),
      body: Obx(
        () => _chatsController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                itemCount: _chatsController.chatRoomList.length,
                separatorBuilder: (context, index) =>
                    SizedBox(height: context.getHeight * .005),
                itemBuilder: (BuildContext context, int index) {
                  return ChatRoomCard(
                    chatRoomBackgroundColor: getChatRoomBackgroundColor(index),
                    userCardBackgroundColor: getUserCardBackgroundColor(index),
                    roomModel: _chatsController.chatRoomList[index],
                    receiverPhotoLink: _chatsController
                        .getReceiverModel(_chatsController.chatRoomList[index])
                        .photoLink,
                    onTap: () => NavigationRoute.instance.toNamed(
                        Routes.chatDetail,
                        arguments: _chatsController.chatRoomList[index]),
                  );
                },
              ),
      ),
    );
  }
}
