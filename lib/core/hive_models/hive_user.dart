import 'package:hive/hive.dart';

part 'hive_user.g.dart';

@HiveType(typeId: 1)
class HiveUserObject extends HiveObject {
  @HiveField(0)
  int? userId;
  @HiveField(1)
  String? username;
  @HiveField(2)
  String? password;
  @HiveField(3)
  String? email;
  @HiveField(4)
  String? name;
  @HiveField(5)
  String? surname;
  @HiveField(6)
  String? desc;
  @HiveField(7)
  int? cityId;
  @HiveField(8)
  int? districtId;
  @HiveField(9)
  String? profilePictureUrl;
  @HiveField(10)
  String? address;
  @HiveField(11)
  String? lat;
  @HiveField(12)
  String? lng;
  @HiveField(13)
  int? userTypeId;

  HiveUserObject({
    this.userId,
    this.username,
    this.password,
    this.email,
    this.name,
    this.surname,
    this.desc,
    this.cityId,
    this.districtId,
    this.profilePictureUrl,
    this.address,
    this.lat,
    this.lng,
    this.userTypeId,
  });

  HiveUserObject.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    name = json['name'];
    surname = json['surname'];
    desc = json['desc'];
    cityId = json['cityId'];
    districtId = json['districtId'];
    profilePictureUrl = json['profilePictureUrl'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    userTypeId = json['userTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['username'] = username;
    data['password'] = password;
    data['email'] = email;
    data['name'] = name;
    data['surname'] = surname;
    data['desc'] = desc;
    data['cityId'] = cityId;
    data['districtId'] = districtId;
    data['profilePictureUrl'] = profilePictureUrl;
    data['address'] = address;
    data['lat'] = lat;
    data['lng'] = lng;
    data['userTypeId'] = userTypeId;
    return data;
  }
}
