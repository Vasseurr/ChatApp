import 'package:chat_app/core/base/base_model.dart';
import 'package:chat_app/product/model/user_model.dart';

class RoomModel extends IBaseModel<RoomModel> {
  String? id;
  String? entityStatus;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  List<UserModel>? users;
  UserModel? onlineUser;

  RoomModel({
    this.id,
    this.entityStatus,
    this.createdDate,
    this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
    this.users,
    this.onlineUser,
  });

  RoomModel copyWith({
    String? id,
    String? entityStatus,
    String? createdDate,
    String? createdBy,
    String? modifiedDate,
    String? modifiedBy,
    List<UserModel>? users,
    UserModel? onlineUser,
  }) {
    return RoomModel(
      id: id ?? this.id,
      entityStatus: entityStatus ?? this.entityStatus,
      createdDate: createdDate ?? this.createdDate,
      createdBy: createdBy ?? this.createdBy,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      users: users ?? this.users,
      onlineUser: onlineUser ?? this.onlineUser,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'entityStatus': entityStatus,
      'createdDate': createdDate,
      'createdBy': createdBy,
      'modifiedDate': modifiedDate,
      'modifiedBy': modifiedBy,
      'users': users,
      'onlineUser': onlineUser,
    };
  }

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'] as String?,
      entityStatus: json['entityStatus'] as String?,
      createdDate: json['createdDate'] as String?,
      createdBy: json['createdBy'] as String?,
      modifiedDate: json['modifiedDate'] as String?,
      modifiedBy: json['modifiedBy'] as String?,
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      onlineUser: json['onlineUser'] as UserModel?,
    );
  }

  @override
  String toString() =>
      "RoomModel(id: $id,entityStatus: $entityStatus,createdDate: $createdDate,createdBy: $createdBy,modifiedDate: $modifiedDate,modifiedBy: $modifiedBy,users: $users,onlineUser: $onlineUser)";

  @override
  int get hashCode => Object.hash(id, entityStatus, createdDate, createdBy,
      modifiedDate, modifiedBy, users, onlineUser);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoomModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          entityStatus == other.entityStatus &&
          createdDate == other.createdDate &&
          createdBy == other.createdBy &&
          modifiedDate == other.modifiedDate &&
          modifiedBy == other.modifiedBy &&
          users == other.users &&
          onlineUser == other.onlineUser;

  @override
  RoomModel fromJson(Map<String, dynamic> json) {
    return RoomModel.fromJson(json);
  }
}
