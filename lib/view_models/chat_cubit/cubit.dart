import 'dart:io';

import 'package:educatly/infrastructure/enums.dart';
import 'package:educatly/models/chat_room_model.dart';
import 'package:educatly/models/message_model.dart';
import 'package:educatly/models/message_request.dart';
import 'package:educatly/models/user_model.dart';
import 'package:educatly/services/chat_service.dart';
import 'package:educatly/services/users_service.dart';
import 'package:educatly/view_models/chat_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatStates());

  static ChatCubit get(context) => BlocProvider.of(context);
  final ChatService _chatService = ChatService();
  final UsersService _usersService = UsersService();
  final SendMessageRequest sendMessageRequest = SendMessageRequest.instance();

  List<ChatRoom> chatRooms = [];
  List<UserModel> users = [];
  UserModel? userToChat;

  searchRooms({required String query}) {
    chatRooms = [];
    emit(SearchChatLoadingState());
    _chatService.searchChatRooms(query: query).then((value) {
      chatRooms = value;
      emit(SearchChatSuccessState());
    }).catchError((error) {
      emit(SearchChatErrorState());
    });
  }

  setUser({required UserModel userModel}) {
    userToChat = userModel;
    emit(OnChangeChats());
  }

  sendMessage({
    required String recieverId,
  }) {
    sendMessageRequest.recieverId = recieverId;
    sendMessageRequest.type = MessageEnum.text;
    emit(SendMessageLoadingState());
    _chatService
        .sendMessage(
      request: sendMessageRequest,
    )
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState(error.toString()));
    });
  }

  sendImage({
    required String recieverId,
    required File file,
  }) async {
    sendMessageRequest.recieverId = recieverId;
    sendMessageRequest.type = MessageEnum.image;
    emit(SendMessageLoadingState());
    String imageUrl = await _chatService.sendImageMessage(file);
    sendMessageRequest.message = imageUrl;
    _chatService
        .sendMessage(
      request: sendMessageRequest,
    )
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState(error.toString()));
    });
  }

  Stream<List<MessageModel>> getMessages({required String recieverId}) {
    return _chatService.getMessages(recieverId: recieverId);
  }

  Stream<UserModel> getUserbyId({required String recieverId}) {
    return _chatService.getUserbyId(userId: recieverId);
  }

  Stream<List<ChatRoom>> getRooms() {
    return _chatService.getChatRooms();
  }

  void setChatMessageSeen({required MessageModel messageModel}) {
    _chatService.setChatMessageSeen(messageModel: messageModel);
  }

  void deleteChatRoom({required String roomId}) {
    _chatService.deleteChatRoom(roomId: roomId);
  }

  void changeStatus({required ChatStatus status}) {
    _chatService.setUserState(status);
  }

  getSuggested() async {
    emit(SearchSuggestedLoadingState());
    await _usersService.getUsers().then((value) {
      users = value;
      emit(SearchSuggestedSuccessState());
    }).catchError((error) {
      emit(SearchSuggestedErrorState());
    });
  }

  searchSuggested({required String query}) async {
    emit(SearchSuggestedLoadingState());
    await _usersService.searchUsers(query: query).then((value) {
      users = value;
      emit(SearchSuggestedSuccessState());
    }).catchError((error) {
      emit(SearchSuggestedErrorState());
    });
  }
}
