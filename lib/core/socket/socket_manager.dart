import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketManager {
  static final SocketManager _instance = SocketManager._init();
  static SocketManager get instance => _instance;

  SocketManager._init();

  late io.Socket socket;

  Future<void> initSocket({required String roomId}) async {
    log('Connecting to chat service');
    socket = io.io('ws://192.168.26.2:8085', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'force new connection': true,
      'query': {
        'room': roomId,
      }
    });
    socket.connect();
    socket.onConnect((_) {
      log('connected to websocket');
    });
  }

  void close() {
    socket.disconnect()
      ..dispose()
      ..close();
  }
}
