import 'package:educatly/constants.dart';
import 'package:educatly/infrastructure/local_storage.dart';
import 'package:educatly/models/user_model.dart';
import 'package:educatly/services/auth_service.dart';
import 'package:educatly/view_models/settings_cubit/states.dart';
import 'package:educatly/views/auth_views/login_view.dart';
import 'package:educatly/views/chat_views/messages_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingCubit extends Cubit<SettingStates> {
  SettingCubit() : super(SettingStates());

  static SettingCubit get(context) => BlocProvider.of(context);
  final AuthService _authService = AuthService();
  bool isDarkMode = false;
  UserModel? user;

  onChangeDarkMode() {
    isDarkMode = !isDarkMode;
    if (isDarkMode) {
      theme = darkTheme;
      CacheHelper.saveData(
        key: themeRef,
        value: isDarkMode,
      );
      emit(OnChangeSettingState());
    } else {
      theme = lightTheme;
      CacheHelper.saveData(
        key: themeRef,
        value: isDarkMode,
      );
      emit(OnChangeSettingState());
    }
  }

  Future<void> getUser() async {
    user = null;
    emit(GetUserDataLoadingState());
    _authService.getUser().then((value) {
      user = value;
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      emit(GetUserDataErrorState(error.toString()));
    });
  }

  ThemeData getIsDarkMode() {
    var value = CacheHelper.getData(key: "themeData");
    if (value != null) {
      if (value) {
        isDarkMode = value;
        emit(OnChangeSettingState());
        return darkTheme;
      } else {
        isDarkMode = value;
        emit(OnChangeSettingState());
        return lightTheme;
      }
    } else {
      emit(OnChangeSettingState());
      return lightTheme;
    }
  }

  Future<void> logout() async {
    await _authService.logOut().then((value) {
      emit(OnChangeSettingState());
    });
  }

  Widget currentView() {
    if (user == null) {
      return const LoginView();
    } else {
      return const MessagesView();
    }
  }
}
