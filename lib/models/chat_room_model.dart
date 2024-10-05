import 'package:educatly/models/user_model.dart';

class ChatRoom {
  final UserModel reciverData;
  final String roomId;
  final DateTime? timeSent;

  ChatRoom({
    required this.reciverData,
    required this.roomId,
    this.timeSent,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reciverData': reciverData.toJson(),
      'roomId': roomId,
      'timeSent': DateTime.now().toUtc().millisecondsSinceEpoch,
    };
  }

  factory ChatRoom.fromMap(Map<String, dynamic> map) {
    return ChatRoom(
      reciverData: UserModel.fromJson(map['reciverData']),
      roomId: map['roomId'] as String,
      timeSent: map['timeSent'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['timeSent'] as int)
          : null,
    );
  }
}
