
import 'package:educatly/infrastructure/enums.dart';
import 'package:educatly/infrastructure/utils.dart';

class MessageModel {
  final String reciverId;
  final String senderId;
  final String message;
  final String messageId;
  final bool isSeen;
  final MessageEnum messageType;
  final DateTime? timeSent;
  MessageModel({
    required this.reciverId,
    required this.senderId,
    required this.message,
    required this.messageId,
    required this.isSeen,
    required this.messageType,
    this.timeSent,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reciverId': reciverId,
      'senderId': senderId,
      'message': message,
      'messageId': messageId,
      'isSeen': isSeen,
      'messageType': messageType.name,
      'timeSent': DateTime.now().toUtc().millisecondsSinceEpoch,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      reciverId: map['reciverId'] as String,
      senderId: map['senderId'] as String,
      message: map['message'] as String,
      messageId: map['messageId'] as String,
      isSeen: map['isSeen'] as bool,
      messageType: EnumUtil.strToEnum(MessageEnum.values, map['messageType']),
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent'] as int),
    );
  }
}
