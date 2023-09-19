import '../../core/base/base_model.dart';

class UserModel extends IBaseModel<UserModel> {
  String? id;
  String? entityStatus;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? password;
  String? photoLink;

  UserModel({
    this.id,
    this.entityStatus,
    this.createdDate,
    this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
    this.firstName,
    this.lastName,
    this.userName,
    this.email,
    this.password,
    this.photoLink,
  });

  UserModel copyWith({
    String? id,
    String? entityStatus,
    String? createdDate,
    String? createdBy,
    String? modifiedDate,
    String? modifiedBy,
    String? firstName,
    String? lastName,
    String? userName,
    String? email,
    String? password,
    String? photoLink,
  }) {
    return UserModel(
      id: id ?? this.id,
      entityStatus: entityStatus ?? this.entityStatus,
      createdDate: createdDate ?? this.createdDate,
      createdBy: createdBy ?? this.createdBy,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      photoLink: photoLink ?? this.photoLink,
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
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'password': password,
      'photoLink': photoLink,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      entityStatus: json['entityStatus'] as String?,
      createdDate: json['createdDate'] as String?,
      createdBy: json['createdBy'] as String?,
      modifiedDate: json['modifiedDate'] as String?,
      modifiedBy: json['modifiedBy'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      photoLink: json['photoLink'] as String?,
    );
  }

  @override
  String toString() =>
      "UserModel(id: $id,entityStatus: $entityStatus,createdDate: $createdDate,createdBy: $createdBy,modifiedDate: $modifiedDate,modifiedBy: $modifiedBy,firstName: $firstName,lastName: $lastName,userName: $userName,email: $email,password: $password,photoLink: $photoLink)";

  @override
  int get hashCode => Object.hash(
      id,
      entityStatus,
      createdDate,
      createdBy,
      modifiedDate,
      modifiedBy,
      firstName,
      lastName,
      userName,
      email,
      password,
      photoLink);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          entityStatus == other.entityStatus &&
          createdDate == other.createdDate &&
          createdBy == other.createdBy &&
          modifiedDate == other.modifiedDate &&
          modifiedBy == other.modifiedBy &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          userName == other.userName &&
          email == other.email &&
          password == other.password &&
          photoLink == other.photoLink;

  @override
  UserModel fromJson(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }
}
