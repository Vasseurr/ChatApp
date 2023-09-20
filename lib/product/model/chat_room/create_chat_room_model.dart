import 'package:chat_app/core/base/base_model.dart';
import 'package:chat_app/product/model/user_model.dart';

class CreateChatRoomModel extends IBaseModel<CreateChatRoomModel> {
  UserModel? onlineUser;
  List<UserModel>? users;

  CreateChatRoomModel({
    this.onlineUser,
    this.users,
  });

  CreateChatRoomModel copyWith({
    UserModel? onlineUser,
    List<UserModel>? users,
  }) {
    return CreateChatRoomModel(
      onlineUser: onlineUser ?? this.onlineUser,
      users: users ?? this.users,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'onlineUser': onlineUser,
      'users': users,
    };
  }

  factory CreateChatRoomModel.fromJson(Map<String, dynamic> json) {
    return CreateChatRoomModel(
      onlineUser: json['onlineUser'] == null
          ? null
          : UserModel.fromJson(json['onlineUser'] as Map<String, dynamic>),
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  String toString() =>
      "CreateChatRoomModel(onlineUser: $onlineUser,users: $users)";

  @override
  int get hashCode => Object.hash(onlineUser, users);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateChatRoomModel &&
          runtimeType == other.runtimeType &&
          onlineUser == other.onlineUser &&
          users == other.users;

  @override
  CreateChatRoomModel fromJson(Map<String, dynamic> json) {
    return CreateChatRoomModel.fromJson(json);
  }
}
