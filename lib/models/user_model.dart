import 'package:educatly/infrastructure/enums.dart';
import 'package:educatly/infrastructure/utils.dart';

class UserModel {
  String? email,
      firstName,
      lastName,
      personalId,
      profilePictureId,
      password;
  Gender? gender;
  ChatStatus status = ChatStatus.offline;

  UserModel.instance();

  UserModel(
      {this.email,
      this.firstName,
      this.lastName,
      this.password,
      this.personalId,
      this.profilePictureId});

  UserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    gender = EnumUtil.strToEnum(Gender.values, json['gender']);
    personalId = json['personalId'];

    profilePictureId = json['profilePictureId'];
    status = EnumUtil.strToEnumNullable(ChatStatus.values, json['status']) ??
        ChatStatus.offline;
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'password': password,
        'gender': gender != null ? gender!.name : Gender.male.name,
        'personalId': personalId,
        'profilePictureId': profilePictureId,
        'status': status.name,
      };

  getFullName() {
    return "$firstName $lastName";
  }
}
