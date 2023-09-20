import 'dart:developer';

import 'package:chat_app/core/extension/string_extension.dart';
import 'package:chat_app/core/socket/socket_manager.dart';
import 'package:chat_app/product/view/chat_detail/ui/chat_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../model/message_model.dart';
import '../controller/chat_detail_controller.dart';

mixin ChatDetailMixin on State<ChatDetailPage> {
  final ChatDetailController _chatDetailController =
      Get.find<ChatDetailController>();

  // late io.Socket socket;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      _chatDetailController.setChatRoomModel(widget.chatRoomModel);
      if (!widget.chatRoomModel.id.isNotNullOrEmpty()) return;
      await _chatDetailController.callRoomMessages(widget.chatRoomModel.id!);
      await initSocket();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _chatDetailController.scrollJump();
      });
      // _chatDetailController.scrollJump();
    });
  }

  Future<void> initSocket() async {
    await SocketManager.instance.initSocket(roomId: widget.chatRoomModel.id!);
    /*log('Connecting to chat service');
    socket = io.io('ws://192.168.26.2:8085', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'force new connection': true,
      'query': {
        'room': widget.roomId,
      }
    });
    socket.connect();
    socket.onConnect((_) {
      log('connected to websocket');
    });*/
    //socket.onConnectError((data) => log("Error -> " + data));
    SocketManager.instance.socket.on('get_message', (message) {
      //final map = jsonDecode(message).cast<Map<String, dynamic>>();
      try {
        MessageModel model = MessageModel.fromJson(message);
        inspect(model);
        _chatDetailController.addMessage(model);
      } catch (e) {
        log("Exception $e");
        inspect(message);
      }
    });
  }

  @override
  void dispose() {
    _chatDetailController.textEditingController.dispose();
    SocketManager.instance.close();
    /* socket.disconnect()
      ..dispose()
      ..close();*/
    super.dispose();
  }
}
