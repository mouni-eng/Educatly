import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educatly/constants.dart';
import 'package:educatly/models/user_model.dart';

class UsersService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserModel>> getUsers() async {
    List<UserModel> users = [];
    await _firestore.collection(userRef).get().then((value) {
      for (var user in value.docs) {
        users.add(UserModel.fromJson(user.data()));
      }
    });
    return users;
  }

  Future<List<UserModel>> searchUsers({required String query}) async {
    return Future.delayed(const Duration(milliseconds: 200), () async {
      return await _firestore.collection(userRef).get().then((value) {
        List<UserModel> users = [];
        for (var user in value.docs) {
          users.add(UserModel.fromJson(user.data()));
        }
        return users
            .where((item) =>
                item.getFullName()!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    });
  }
}
