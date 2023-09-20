import 'package:chat_app/core/init/navigation/navigation_route.dart';
import 'package:chat_app/product/view/chats/controller/chats_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/routes/app_routes.dart';
import 'widget/chat_room_card.dart';

class ChatsPage extends StatelessWidget {
  ChatsPage({Key? key}) : super(key: key);

  final ChatsController _chatsController = Get.find<ChatsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
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
              Icons.add_box_rounded,
              size: AppConstants.midRadius,
            ),
          )
        ],
      ),
      body: Obx(
        () => _chatsController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _chatsController.chatRoomList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ChatRoomCard(
                    roomModel: _chatsController.chatRoomList[index],
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
