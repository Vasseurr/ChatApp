import '../../core/base/base_service.dart';
import '../../core/constants/endpoint_url.dart';
import '../model/user_model.dart';

class UserService extends BaseService {
  static final UserService _instance = UserService._init();
  static UserService get instance => _instance;

  UserService._init();

  Future<List<UserModel>> getAllUsers() async {
    String url = EndPointUrl.VERSION + EndPointUrl.USER + EndPointUrl.LIST_ALL;

    return await get<UserModel>(url, model: UserModel());
  }
}
