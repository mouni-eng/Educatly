import 'dart:io';
import 'package:educatly/infrastructure/enums.dart';
import 'package:educatly/infrastructure/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:educatly/models/user_model.dart';
import 'package:educatly/services/auth_service.dart';
import 'package:educatly/view_models/auth_cubit/states.dart';

import '../../services/file_service.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthStates());

  static AuthCubit get(context) => BlocProvider.of(context);

  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  final AuthService _authService = AuthService();
  final FileService _fileService = FileService();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> resetFormKey = GlobalKey<FormState>();

  File? profileImage;
  UserModel signUpRequest = UserModel.instance();
  String? resetEmail;

  chooseImage(File file) async {
    profileImage = file;
    emit(ChooseProfileImageState());
  }

  onChangeFirstName(String value) {
    signUpRequest.firstName = value;
    emit(OnChangeState());
  }

  onChangeLastName(String value) {
    signUpRequest.lastName = value;
    emit(OnChangeState());
  }

  onChangeGender(Gender value) {
    signUpRequest.gender = value;
    emit(OnChangeState());
  }

  onChangeEmailAddress(String value) {
    signUpRequest.email = value;
    emit(OnChangeState());
  }

  onChangePassword(String value) {
    signUpRequest.password = value;
    emit(OnChangeState());
  }

  onChangeResetEmail(String value) {
    resetEmail = value;
    emit(OnChangeState());
  }

  uploadProfilePicture() async {
    if (profileImage != null && signUpRequest.profilePictureId == null) {
      await _fileService
          .uploadFile(image: profileImage!, header: "users")
          .then((value) {
        signUpRequest.profilePictureId = value;
      }).catchError((error) {
        printLn(error);
      });
    }
  }

  logIn() {
    emit(LogInLoadingState());
    _authService
        .login(email: signUpRequest.email, password: signUpRequest.password)
        .then((value) {
      emit(LogInSuccessState());
    }).catchError((error) {
      printLn(error.toString());
      emit(LogInErrorState(error: error.toString()));
    });
  }

  saveUser() {
    emit(RegisterLoadingState());
    _authService.register(model: signUpRequest).then((value) async {
      await uploadProfilePicture();
      _authService.saveUser(model: signUpRequest);
      emit(RegisterSuccessState());
    }).catchError((error) {
      emit(RegisterErrorState(error: error.message));
    });
  }

  void resetPassword() {
    emit(ResetPasswordLoadingState());
    _authService.resetPassword(email: resetEmail!).then((value) {
      emit(ResetPasswordSuccessState());
    }).catchError((error) {
      emit(ResetPasswordErrorState());
    });
  }
}
