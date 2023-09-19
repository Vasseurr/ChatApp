import '../../core/base/base_service.dart';
import '../../core/constants/endpoint_url.dart';
import '../model/room_model.dart';

class RoomService extends BaseService {
  static final RoomService _instance = RoomService._init();
  static RoomService get instance => _instance;

  RoomService._init();

  Future<List<RoomModel>> getAllRooms() async {
    String url = EndPointUrl.VERSION + EndPointUrl.ROOM + EndPointUrl.LIST_ALL;

    return await get<RoomModel>(url, model: RoomModel());
  }
}
