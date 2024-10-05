import 'dart:async';
import 'package:chat_bubbles/date_chips/date_chip.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:educatly/constants.dart';
import 'package:educatly/infrastructure/enums.dart';
import 'package:educatly/infrastructure/utils.dart';
import 'package:educatly/models/message_model.dart';
import 'package:educatly/models/user_model.dart';
import 'package:educatly/size_config.dart';
import 'package:educatly/view_models/chat_cubit/cubit.dart';
import 'package:educatly/view_models/chat_cubit/states.dart';
import 'package:educatly/views/chat_views/widgets/message_bubble.dart';
import 'package:educatly/widgets/circle_image.dart';
import 'package:educatly/widgets/custom_formField.dart';
import 'package:educatly/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatDetailsView extends StatefulWidget {
  const ChatDetailsView({
    super.key,
    required this.recieverId,
  });

  final String recieverId;

  @override
  State<ChatDetailsView> createState() => _ChatDetailsViewState();
}

class _ChatDetailsViewState extends State<ChatDetailsView> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
    _scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 500), () {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ChatCubit cubit = ChatCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: color.canvasColor,
              elevation: 20,
              surfaceTintColor: Colors.transparent,
              title: StreamBuilder<UserModel>(
                  stream: cubit.getUserbyId(recieverId: widget.recieverId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox();
                    }
                    return Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: color.primaryColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(
                          width: width(10),
                        ),
                        BorderImage(
                          imageSrc: snapshot.data!.profilePictureId,
                          avatarLetters: NameUtil.getInitials(
                            snapshot.data!.firstName,
                            snapshot.data!.lastName,
                          ),
                          cawidth: width(50),
                          caheight: height(50),
                        ),
                        SizedBox(
                          width: width(10),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              fontSize: width(16),
                              text: snapshot.data!.getFullName().toString(),
                              fontWeight: FontWeight.w600,
                            ),
                            CustomText(
                              fontSize: width(12),
                              text: snapshot.data!.status.name,
                              color: color.hintColor,
                            ),
                          ],
                        )
                      ],
                    );
                  }),
            ),
            body: StreamBuilder<List<MessageModel>>(
              stream: cubit.getMessages(recieverId: widget.recieverId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting &&
                    snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                SchedulerBinding.instance.addPostFrameCallback((_) {
                  _scrollController
                      .jumpTo(_scrollController.position.maxScrollExtent);
                });

                return Container(
                  color: color.colorScheme.tertiary,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            MessageModel message = snapshot.data![index];
                            if (!message.isSeen &&
                                message.reciverId == userModel?.personalId) {
                              cubit.setChatMessageSeen(messageModel: message);
                            }

                            if (index != 0) {
                              if (DateUtil.isSameDate(
                                  snapshot.data![index - 1].timeSent!,
                                  message.timeSent!)) {
                                return MessageBubble(
                                  message: message,
                                  isSender:
                                      message.senderId == userModel!.personalId,
                                );
                              } else {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                        child:
                                            DateChip(date: message.timeSent!)),
                                    MessageBubble(
                                      message: message,
                                      isSender: message.senderId ==
                                          userModel!.personalId,
                                    ),
                                  ],
                                );
                              }
                            } else {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                      child: DateChip(
                                    date: message.timeSent!,
                                  )),
                                  MessageBubble(
                                    message: message,
                                    isSender: message.senderId ==
                                        userModel!.personalId,
                                  )
                                ],
                              );
                            }
                          },
                          itemCount: snapshot.data!.length,
                        ),
                      ),
                      SizedBox(
                        height: height(10),
                      ),
                      SafeArea(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: height(20),
                            horizontal: width(20),
                          ),
                          decoration: BoxDecoration(
                            color: color.canvasColor,
                            boxShadow: [boxShadow],
                          ),
                          child: Row(
                            children: [
                              CustomImagePicker(
                                widgetBuilder: () => SvgPicture.asset(
                                  "assets/icons/Camera.svg",
                                ),
                                onFilePick: (file) {
                                  cubit.sendImage(
                                    recieverId: widget.recieverId,
                                    file: file,
                                  );
                                },
                              ),
                              SizedBox(
                                width: width(14),
                              ),
                              Expanded(
                                child: CustomFormField(
                                  hintText: "Send message",
                                  fillColor: color.splashColor,
                                  controller: _messageController,
                                  onChange: (value) {
                                    if (value.isNotEmpty) {
                                      cubit.sendMessageRequest.message = value;
                                      cubit.changeStatus(
                                        status: ChatStatus.typing,
                                      );
                                    } else if (value.isEmpty) {
                                      cubit.changeStatus(
                                        status: ChatStatus.online,
                                      );
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                width: width(14),
                              ),
                              ConditionalBuilder(
                                  condition: state is! SendMessageLoadingState,
                                  fallback: (context) =>
                                      const CircularProgressIndicator
                                          .adaptive(),
                                  builder: (context) {
                                    return InkWell(
                                      onTap: () {
                                        if (_messageController
                                            .text.isNotEmpty) {
                                          cubit.sendMessage(
                                            recieverId: widget.recieverId,
                                          );
                                          _messageController.clear();
                                          cubit.changeStatus(
                                              status: ChatStatus.online);
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width(15),
                                            vertical: height(15)),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: color.primaryColor,
                                        ),
                                        child: SvgPicture.asset(
                                          "assets/icons/chat.svg",
                                          color: Colors.white,
                                          width: width(20),
                                          height: height(20),
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        });
  }
}
