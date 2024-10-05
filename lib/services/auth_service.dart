import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educatly/infrastructure/local_storage.dart';
import 'package:educatly/infrastructure/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:educatly/constants.dart';
import 'package:educatly/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  register({required UserModel model}) async {
    await _auth
        .createUserWithEmailAndPassword(
            email: model.email!, password: model.password!)
        .then((value) {
      model.personalId = value.user!.uid;
      saveUser(model: model);
    });
  }

  saveUser({required UserModel model}) async {
    await _firestore
        .collection(userRef)
        .doc(model.personalId)
        .set(model.toJson());
    await SecureStorage.saveData(key: "uid", value: model.personalId);
    await getUser();
  }

  login({required email, required password}) async {
    var response = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    await SecureStorage.saveData(key: "uid", value: response.user!.uid);
    await getUser();
  }

  Future<UserModel?> getUser() async {
    var uId = await SecureStorage.getData(key: "uid");
    UserModel? model;
    if (uId != null) {
      var response = await _firestore.collection(userRef).doc(uId).get();
      if (response.data() != null) {
        model = UserModel.fromJson(response.data()!);
        userModel = model;
      }
    }
    printLn(model?.toJson());
    return model;
  }

  resetPassword({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  logOut() async {
    await FirebaseAuth.instance.signOut().then((value) {
      SecureStorage.removeData(
        key: 'uid',
      );
    });
  }

  updateProfile({required String profilePicture}) async {
    await _firestore
        .collection(userRef)
        .doc(userModel!.personalId)
        .update({"profilePictureId": profilePicture});
  }

  Future<void> updateUser() async {
    await _firestore
        .collection(userRef)
        .doc(userModel?.personalId)
        .update(userModel!.toJson());
    getUser();
  }
}
