class ChatStates {}

class OnChangeChats extends ChatStates {}

class SearchChatLoadingState extends ChatStates {}

class SearchChatSuccessState extends ChatStates {}

class SearchChatErrorState extends ChatStates {}

class SendMessageLoadingState extends ChatStates {}

class SendMessageSuccessState extends ChatStates {}

class SendMessageErrorState extends ChatStates {

  final String error;

  SendMessageErrorState(this.error);
}

class SearchSuggestedLoadingState extends ChatStates {}

class SearchSuggestedSuccessState extends ChatStates {}

class SearchSuggestedErrorState extends ChatStates {}