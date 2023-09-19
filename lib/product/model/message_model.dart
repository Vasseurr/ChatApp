import 'package:chat_app/product/model/room_model.dart';
import 'package:chat_app/product/model/user_model.dart';

import '../../core/base/base_model.dart';

class MessageModel extends IBaseModel<MessageModel> {
  String? id;
  String? entityStatus;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  UserModel? sender;
  UserModel? receiver;
  String? content;
  RoomModel? room;

  MessageModel({
    this.id,
    this.entityStatus,
    this.createdDate,
    this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
    this.sender,
    this.receiver,
    this.content,
    this.room,
  });

  MessageModel copyWith({
    String? id,
    String? entityStatus,
    String? createdDate,
    String? createdBy,
    String? modifiedDate,
    String? modifiedBy,
    UserModel? sender,
    UserModel? receiver,
    String? content,
    RoomModel? room,
  }) {
    return MessageModel(
      id: id ?? this.id,
      entityStatus: entityStatus ?? this.entityStatus,
      createdDate: createdDate ?? this.createdDate,
      createdBy: createdBy ?? this.createdBy,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      content: content ?? this.content,
      room: room ?? this.room,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'entityStatus': entityStatus,
      'createdDate': createdDate,
      'createdBy': createdBy,
      'modifiedDate': modifiedDate,
      'modifiedBy': modifiedBy,
      'sender': sender,
      'receiver': receiver,
      'content': content,
      'room': room,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String?,
      entityStatus: json['entityStatus'] as String?,
      createdDate: json['createdDate'] as String?,
      createdBy: json['createdBy'] as String?,
      modifiedDate: json['modifiedDate'] as String?,
      modifiedBy: json['modifiedBy'] as String?,
      sender: json['sender'] == null
          ? null
          : UserModel.fromJson(json['sender'] as Map<String, dynamic>),
      receiver: json['receiver'] == null
          ? null
          : UserModel.fromJson(json['receiver'] as Map<String, dynamic>),
      content: json['content'] as String?,
      room: json['room'] == null
          ? null
          : RoomModel.fromJson(json['room'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() =>
      "MessageModel(id: $id,entityStatus: $entityStatus,createdDate: $createdDate,createdBy: $createdBy,modifiedDate: $modifiedDate,modifiedBy: $modifiedBy,sender: $sender,receiver: $receiver,content: $content,room: $room)";

  @override
  int get hashCode => Object.hash(id, entityStatus, createdDate, createdBy,
      modifiedDate, modifiedBy, sender, receiver, content, room);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          entityStatus == other.entityStatus &&
          createdDate == other.createdDate &&
          createdBy == other.createdBy &&
          modifiedDate == other.modifiedDate &&
          modifiedBy == other.modifiedBy &&
          sender == other.sender &&
          receiver == other.receiver &&
          content == other.content &&
          room == other.room;

  @override
  MessageModel fromJson(Map<String, dynamic> json) {
    return MessageModel.fromJson(json);
  }
}
