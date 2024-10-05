import 'package:educatly/constants.dart';
import 'package:educatly/infrastructure/enums.dart';
import 'package:educatly/infrastructure/utils.dart';
import 'package:educatly/models/chat_room_model.dart';
import 'package:educatly/models/message_model.dart';
import 'package:educatly/size_config.dart';
import 'package:educatly/view_models/chat_cubit/cubit.dart';
import 'package:educatly/views/chat_views/chat_view.dart';
import 'package:educatly/widgets/circle_image.dart';
import 'package:educatly/widgets/custom_navigation.dart';
import 'package:educatly/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatRoomWidget extends StatelessWidget {
  const ChatRoomWidget({
    super.key,
    required this.roomModel,
    required this.onDissmiss,
  });

  final ChatRoom roomModel;
  final void Function(DismissDirection) onDissmiss;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: onDissmiss,
      background: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width(20),
        ),
        decoration: BoxDecoration(
          color: color.colorScheme.error.withOpacity(0.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomText(
              fontSize: width(14),
              text: "Delete",
              color: color.colorScheme.error,
            ),
            SizedBox(
              width: width(12),
            ),
            SvgPicture.asset("assets/icons/Trash.svg"),
          ],
        ),
      ),
      child: GestureDetector(
        onTap: () {
          navigateTo(
            view: ChatDetailsView(recieverId: roomModel.roomId),
            context: context,
          );
        },
        child: StreamBuilder<List<MessageModel>>(
          stream:
              ChatCubit.get(context).getMessages(recieverId: roomModel.roomId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }

            List<MessageModel> messages = snapshot.data!;
            return Container(
              decoration: BoxDecoration(
                color: color.scaffoldBackgroundColor,
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BorderImage(
                        imageSrc: roomModel.reciverData.profilePictureId,
                        avatarLetters: NameUtil.getInitials(
                          roomModel.reciverData.firstName,
                          roomModel.reciverData.lastName,
                        ),
                        cawidth: width(70),
                        caheight: height(60),
                      ),
                      SizedBox(
                        width: width(20),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              fontSize: width(14),
                              text: roomModel.reciverData
                                  .getFullName()
                                  .toString(),
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(
                              height: height(8),
                            ),
                            if (messages.isNotEmpty)
                              messages.last.messageType == MessageEnum.text
                                  ? CustomText(
                                      fontSize: width(12),
                                      text: messages.last.message,
                                      maxlines: 2,
                                      color: messages.last.reciverId ==
                                              userModel?.personalId
                                          ? messages.last.isSeen
                                              ? color.hintColor
                                              : color.primaryColor
                                          : color.hintColor,
                                    )
                                  : Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/Camera.svg",
                                          width: width(15),
                                          height: height(15),
                                        ),
                                        SizedBox(
                                          width: width(5),
                                        ),
                                        CustomText(
                                          fontSize: width(12),
                                          text: "Photo",
                                          color: messages.last.reciverId ==
                                                  userModel?.personalId
                                              ? messages.last.isSeen
                                                  ? color.hintColor
                                                  : color.primaryColor
                                              : color.hintColor,
                                        ),
                                      ],
                                    ),
                          ],
                        ),
                      ),
                      if (messages.isNotEmpty)
                        Expanded(
                            child: Column(
                          children: [
                            CustomText(
                              fontSize: width(14),
                              text: DateUtil.showTimeSelected(
                                  TimeOfDay.fromDateTime(roomModel.timeSent!)),
                              color: messages.last.reciverId ==
                                      userModel?.personalId
                                  ? messages.last.isSeen
                                      ? color.hintColor
                                      : color.primaryColor
                                  : color.hintColor,
                            ),
                            SizedBox(
                              height: height(8),
                            ),
                            if (messages.last.reciverId ==
                                    userModel?.personalId &&
                                !messages.last.isSeen)
                              Badge(
                                backgroundColor: color.primaryColor,
                                label: CustomText(
                                  fontSize: width(10),
                                  text: messages
                                      .where(
                                          (element) => element.isSeen == false)
                                      .length
                                      .toString(),
                                  color: color.primaryColorLight,
                                ),
                              )
                          ],
                        ))
                    ],
                  ),
                  Divider(
                    indent: SizeConfig.screenWidth! / 5,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
