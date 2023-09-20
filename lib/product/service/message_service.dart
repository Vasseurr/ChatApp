import 'package:chat_app/product/model/message/create_message_model.dart';

import '../../core/base/base_service.dart';
import '../../core/constants/endpoint_url.dart';
import '../model/message_model.dart';

class MessageService extends BaseService {
  static final MessageService _instance = MessageService._init();
  static MessageService get instance => _instance;

  MessageService._init();

  Future<List<MessageModel>> getAllMessages(String roomId) async {
    String url = EndPointUrl.VERSION +
        EndPointUrl.MESSAGE +
        EndPointUrl.LIST_ALL_BY_ROOM;

    return await get<MessageModel>(url,
        model: MessageModel(), parameters: {"roomId": roomId});
  }

  Future<MessageModel> saveMessage(
      CreateMessageModel createMessageModel) async {
    String url = EndPointUrl.VERSION + EndPointUrl.MESSAGE + EndPointUrl.SAVE;

    return await post<MessageModel>(url,
        requestModel: createMessageModel, responseModel: MessageModel());
  }
}
