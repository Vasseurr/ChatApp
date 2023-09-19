import '../model/user_model.dart';

class UserFactory {
  static final UserModel user = UserModel(
      id: "540e7c9d-0989-4e9e-9e5f-8a6c5d1e6439",
      entityStatus: "ACTIVE",
      createdDate: "2023-09-18T20:17:01.2594383",
      createdBy: "ktaslan",
      modifiedDate: "2023-09-18T20:17:01.1956085",
      modifiedBy: "ktaslan",
      firstName: "kayahan",
      lastName: "aslan",
      userName: "ktaslan",
      email: "abk@gmail.com",
      password: "121212",
      photoLink: null);

  /*static get user => HiveManager.instance.getUser() == null
      ? null
      : UserModel.fromJson(HiveManager.instance.getUser()!.toJson());*/
}
