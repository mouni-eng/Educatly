class SettingStates {}

class OnChangeSettingState extends SettingStates {}

class GetUserDataLoadingState extends SettingStates {}

class GetUserDataSuccessState extends SettingStates {}

class GetUserDataErrorState extends SettingStates {
  final String error;
  GetUserDataErrorState(this.error);
}