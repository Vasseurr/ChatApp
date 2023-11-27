import 'package:chat_app/core/extension/string_extension.dart';
import 'package:chat_app/product/model/chat_room/create_chat_room_model.dart';

import '../../core/base/base_service.dart';
import '../../core/constants/endpoint_url.dart';
import '../model/chat_room_model.dart';

class ChatRoomService extends BaseService {
  static final ChatRoomService _instance = ChatRoomService._init();
  static ChatRoomService get instance => _instance;

  ChatRoomService._init();

  Future<List<ChatRoomModel>> getAllRooms() async {
    String url = EndPointUrl.VERSION + EndPointUrl.ROOM + EndPointUrl.LIST_ALL;

    return await get<ChatRoomModel>(url, model: ChatRoomModel());
  }

  Future<ChatRoomModel> saveChatRoom(
      CreateChatRoomModel createChatRoomModel) async {
    String url = EndPointUrl.VERSION + EndPointUrl.ROOM + EndPointUrl.SAVE;

    return await post<ChatRoomModel>(url,
        requestModel: createChatRoomModel, responseModel: ChatRoomModel());
  }

  Future<List<ChatRoomModel>> getAllRoomsByUser(String? userId) async {
    if (!userId.isNotNullOrEmpty()) throw Exception("User id not found");
    String url =
        EndPointUrl.VERSION + EndPointUrl.ROOM + EndPointUrl.LIST_ALL_BY_USER;
    url += "/$userId";
    return await get<ChatRoomModel>(url, model: ChatRoomModel());
  }
}
