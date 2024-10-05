import 'package:educatly/infrastructure/enums.dart';

class SendMessageRequest {
  String? recieverId;
  String? message;
  MessageEnum? type;

  SendMessageRequest({
    required this.recieverId,
    required this.message,
    required this.type,
  });

  SendMessageRequest.instance();

}