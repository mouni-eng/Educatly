import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educatly/constants.dart';
import 'package:educatly/infrastructure/enums.dart';
import 'package:educatly/infrastructure/utils.dart';
import 'package:educatly/models/chat_room_model.dart';
import 'package:educatly/models/message_model.dart';
import 'package:educatly/models/message_request.dart';
import 'package:educatly/models/user_model.dart';
import 'package:educatly/services/file_service.dart';
import 'package:flutter/material.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FileService _fileService = FileService();

  Future<void> _saveDataToRoom({
    required UserModel reciver,
    required String text,
  }) async {
    var reciverChatRoom = ChatRoom(
      roomId: userModel!.personalId!,
      reciverData: userModel!,
    );
    await _firestore
        .collection(userRef)
        .doc(reciver.personalId)
        .collection(chatRef)
        .doc(userModel?.personalId)
        .set(reciverChatRoom.toMap());
    var senderChatRoom = ChatRoom(
      roomId: reciver.personalId!,
      reciverData: reciver,
    );
    await _firestore
        .collection(userRef)
        .doc(userModel?.personalId)
        .collection(chatRef)
        .doc(reciver.personalId)
        .set(senderChatRoom.toMap());
  }

  Future<void> _saveMessagesData({
    required MessageModel messageModel,
  }) async {
    await _firestore
        .collection(userRef)
        .doc(userModel?.personalId)
        .collection(chatRef)
        .doc(messageModel.reciverId)
        .collection(messageRef)
        .doc(messageModel.messageId)
        .set(messageModel.toMap());
    await _firestore
        .collection(userRef)
        .doc(messageModel.reciverId)
        .collection(chatRef)
        .doc(userModel?.personalId)
        .collection(messageRef)
        .doc(messageModel.messageId)
        .set(messageModel.toMap());
  }

  Future<void> sendMessage({
    required SendMessageRequest request,
  }) async {
    var userDoc =
        await _firestore.collection(userRef).doc(request.recieverId).get();
    UserModel reciever = UserModel.fromJson(userDoc.data()!);
    MessageModel messageModel = MessageModel(
      reciverId: reciever.personalId!,
      senderId: userModel!.personalId!,
      messageId: UniqueKey().hashCode.toString(),
      message: request.message!,
      isSeen: false,
      messageType: request.type!,
    );
    await _saveDataToRoom(reciver: reciever, text: request.message!);
    await _saveMessagesData(messageModel: messageModel);
  }

  Stream<List<MessageModel>> getMessages({required String recieverId}) {
    return _firestore
        .collection(userRef)
        .doc(userModel?.personalId)
        .collection(chatRef)
        .doc(recieverId)
        .collection(messageRef)
        .orderBy("timeSent")
        .snapshots()
        .map((event) {
      List<MessageModel> messages = [];
      for (var message in event.docs) {
        messages.add(MessageModel.fromMap(message.data()));
      }
      return messages;
    });
  }

  void setUserState(ChatStatus status) async {
    await _firestore.collection(userRef).doc(userModel?.personalId).update({
      'status': status.name,
    });
  }

  Stream<UserModel> getUserbyId({required String userId}) {
    return _firestore
        .collection(userRef)
        .doc(userId)
        .snapshots()
        .map((event) => UserModel.fromJson(event.data()!));
  }

  Stream<List<ChatRoom>> getChatRooms() {
    return _firestore
        .collection(userRef)
        .doc(userModel?.personalId)
        .collection(chatRef)
        .orderBy('timeSent', descending: true)
        .snapshots()
        .map((event) {
      List<ChatRoom> chatRooms = [];
      for (var room in event.docs) {
        try {
          chatRooms.add(ChatRoom.fromMap(room.data()));
        } catch (e) {
          printLn(e.toString());
        }
      }
      return chatRooms;
    });
  }

  void setChatMessageSeen({required MessageModel messageModel}) async {
    try {
      await _firestore
          .collection(userRef)
          .doc(userModel?.personalId)
          .collection(chatRef)
          .doc(messageModel.senderId)
          .collection(messageRef)
          .doc(messageModel.messageId)
          .update({'isSeen': true});
      await _firestore
          .collection(userRef)
          .doc(messageModel.senderId)
          .collection(chatRef)
          .doc(userModel?.personalId)
          .collection(messageRef)
          .doc(messageModel.messageId)
          .update({'isSeen': true});
    } catch (e) {
      printLn(e.toString());
    }
  }

  void deleteChatRoom({required String roomId}) async {
    await _firestore
        .collection(userRef)
        .doc(userModel?.personalId)
        .collection(chatRef)
        .doc(roomId)
        .delete();
  }

  Future<String> sendImageMessage(File imageFile) async {
    return await _fileService.uploadFile(
        image: imageFile, header: "Chats/${userModel?.personalId}");
  }

  Future<List<ChatRoom>> searchChatRooms({required String query}) async {
    List<ChatRoom> chatRooms = [];
    if (query.isNotEmpty || query != "") {
      await _firestore
          .collection(userRef)
          .doc(userModel?.personalId)
          .collection(chatRef)
          .get()
          .then((value) {
        for (var chatRoom in value.docs) {
          chatRooms.add(ChatRoom.fromMap(chatRoom.data()));
        }
      });
    }

    return chatRooms
        .where((item) => item.reciverData
            .getFullName()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
  }
}
