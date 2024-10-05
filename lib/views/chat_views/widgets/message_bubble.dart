import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:educatly/infrastructure/enums.dart';
import 'package:educatly/infrastructure/utils.dart';
import 'package:educatly/models/message_model.dart';
import 'package:educatly/size_config.dart';
import 'package:educatly/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.isSender,
  });

  final MessageModel message;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Bubble(
      messageModel: message,
      bubbleColor: isSender
          ? color.colorScheme.secondary
          : color.colorScheme.secondaryContainer,
      seen: isSender ? message.isSeen : false,
      isSender: isSender,
      dateTime: message.timeSent!,
      type: message.messageType,
      textStyle: TextStyle(
        color: color.primaryColorDark,
        fontSize: width(14),
      ),
    );
  }
}

class Bubble extends StatelessWidget {
  final double bubbleRadius;
  final bool isSender;
  final Color? bubbleColor, seenColor, dateColor;
  final MessageModel messageModel;
  final MessageEnum type;
  final DateTime dateTime;
  final bool tail;
  final bool seen;
  final TextStyle textStyle;
  final BoxConstraints? constraints;

  const Bubble({
    super.key,
    required this.messageModel,
    this.constraints,
    this.bubbleRadius = 16,
    this.isSender = true,
    this.bubbleColor = Colors.white70,
    this.tail = true,
    this.seen = false,
    this.textStyle = const TextStyle(
      color: Colors.black87,
      fontSize: 16,
    ),
    this.seenColor,
    this.dateColor,
    required this.dateTime,
    this.type = MessageEnum.text,
  });

  ///chat bubble builder method
  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    Icon? stateIcon;
    if (seen) {
      stateIcon = Icon(
        Icons.done_all,
        size: 14,
        color: seenColor ?? color.primaryColor,
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        isSender
            ? const Expanded(
                child: SizedBox(
                  width: 5,
                ),
              )
            : Container(),
        UnconstrainedBox(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            color: Colors.transparent,
            constraints: constraints ??
                BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .8),
            child: Container(
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(bubbleRadius),
                  topRight: Radius.circular(bubbleRadius),
                  bottomLeft: Radius.circular(tail
                      ? isSender
                          ? bubbleRadius
                          : 0
                      : 16),
                  bottomRight: Radius.circular(tail
                      ? isSender
                          ? 0
                          : bubbleRadius
                      : 16),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    type == MessageEnum.text
                        ? Text(
                            messageModel.message,
                            style: textStyle,
                            textAlign: TextAlign.left,
                          )
                        : GestureDetector(
                            onTap: () {
                              showImageViewer(
                                context,
                                doubleTapZoomable: true,
                                Image.network(
                                  messageModel.message,
                                ).image,
                                swipeDismissible: false,
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
                                imageUrl: messageModel.message,
                                width: width(270),
                                height: height(200),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                    SizedBox(
                      height: height(3),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                          fontSize: width(10),
                          text: DateUtil.showTimeSelected(
                              TimeOfDay.fromDateTime(dateTime)),
                          color: color.hintColor,
                        ),
                        if (stateIcon != null) ...[
                          SizedBox(
                            width: width(5),
                          ),
                          stateIcon,
                        ]
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
