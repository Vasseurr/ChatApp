import 'package:chat_app/core/base/base_model.dart';
import 'package:chat_app/product/model/chat_room_model.dart';
import 'package:chat_app/product/model/user_model.dart';

class CreateMessageModel extends IBaseModel<CreateMessageModel> {
  UserModel? sender;
  UserModel? receiver;
  String? content;
  ChatRoomModel? chatRoom;

  CreateMessageModel({
    this.sender,
    this.receiver,
    this.content,
    this.chatRoom,
  });

  CreateMessageModel copyWith({
    UserModel? sender,
    UserModel? receiver,
    String? content,
    ChatRoomModel? chatRoom,
  }) {
    return CreateMessageModel(
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      content: content ?? this.content,
      chatRoom: chatRoom ?? this.chatRoom,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'receiver': receiver,
      'content': content,
      'room': chatRoom,
    };
  }

  factory CreateMessageModel.fromJson(Map<String, dynamic> json) {
    return CreateMessageModel(
      sender: json['sender'] == null
          ? null
          : UserModel.fromJson(json['sender'] as Map<String, dynamic>),
      receiver: json['receiver'] == null
          ? null
          : UserModel.fromJson(json['receiver'] as Map<String, dynamic>),
      content: json['content'] as String?,
      chatRoom: json['room'] == null
          ? null
          : ChatRoomModel.fromJson(json['room'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() =>
      "CreateMessageModel(sender: $sender,receiver: $receiver,content: $content,chatRoom: $chatRoom)";

  @override
  int get hashCode => Object.hash(sender, receiver, content, chatRoom);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateMessageModel &&
          runtimeType == other.runtimeType &&
          sender == other.sender &&
          receiver == other.receiver &&
          content == other.content &&
          chatRoom == other.chatRoom;

  @override
  CreateMessageModel fromJson(Map<String, dynamic> json) {
    return CreateMessageModel.fromJson(json);
  }
}
