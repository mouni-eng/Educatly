import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:educatly/constants.dart';
import 'package:educatly/infrastructure/enums.dart';
import 'package:educatly/infrastructure/utils.dart';
import 'package:educatly/models/chat_room_model.dart';
import 'package:educatly/services/chat_service.dart';
import 'package:educatly/size_config.dart';
import 'package:educatly/view_models/chat_cubit/cubit.dart';
import 'package:educatly/view_models/chat_cubit/states.dart';
import 'package:educatly/view_models/settings_cubit/cubit.dart';
import 'package:educatly/view_models/settings_cubit/states.dart';
import 'package:educatly/views/auth_views/login_view.dart';
import 'package:educatly/views/chat_views/new_message_view.dart';
import 'package:educatly/views/chat_views/search_chats_view.dart';
import 'package:educatly/views/chat_views/widgets/chat_room_widget.dart';
import 'package:educatly/widgets/circle_image.dart';
import 'package:educatly/widgets/custom_formField.dart';
import 'package:educatly/widgets/custom_navigation.dart';
import 'package:educatly/widgets/custom_text.dart';
import 'package:educatly/widgets/empty_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({super.key});

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView>
    with WidgetsBindingObserver {
  final ChatService chatService = ChatService();
  final TextEditingController _searchcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        chatService.setUserState(ChatStatus.online);
        break;
      case AppLifecycleState.inactive:
        chatService.setUserState(ChatStatus.offline);
        break;
      case AppLifecycleState.detached:
        chatService.setUserState(ChatStatus.offline);
        break;
      case AppLifecycleState.paused:
        chatService.setUserState(ChatStatus.offline);
        break;
      default:
        chatService.setUserState(ChatStatus.offline);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ChatCubit cubit = ChatCubit.get(context);
          return Scaffold(
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                  child: Padding(
                      padding: padding,
                      child: Column(
                        children: [
                          BlocConsumer<SettingCubit, SettingStates>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              
                              return ConditionalBuilder(
                                  condition: state is! GetUserDataLoadingState,
                                  fallback: (context) => const SizedBox(),
                                  builder: (context) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleImage(
                                              imageSrc: userModel!.profilePictureId,
                                              avatarLetters:
                                                  NameUtil.getInitials(
                                                      userModel!.firstName,
                                                      userModel!.lastName),
                                              cawidth: width(50),
                                              caheight: height(50),
                                            ),
                                            SizedBox(
                                              width: width(15),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  fontSize: width(16),
                                                  text: userModel!
                                                      .getFullName(),
                                                ),
                                                CustomText(
                                                  fontSize: width(14),
                                                  text: userModel!.status.name,
                                                  color: color.hintColor,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                SettingCubit.get(context)
                                                    .onChangeDarkMode();
                                              },
                                              icon: SvgPicture.asset(
                                                "assets/icons/moon.svg",
                                                width: width(24),
                                                height: height(24),
                                                color: color.primaryColorDark,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                SettingCubit.get(context)
                                                    .logout();
                                                Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const LoginView()),
                                                  (Route<dynamic> route) =>
                                                      false,
                                                );
                                              },
                                              icon: SvgPicture.asset(
                                                "assets/icons/log-out.svg",
                                                width: width(24),
                                                height: height(24),
                                                color: color.primaryColorDark,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  });
                            },
                          ),
                          SizedBox(
                            height: height(25),
                          ),
                          SizedBox(
                            height: height(60),
                            child: Row(
                              children: [
                                Expanded(
                                    child: CustomFormField(
                                  controller: _searchcontroller,
                                  hintText: "Search for Chats",
                                  onSubmit: (value) {
                                    cubit.searchRooms(
                                        query: _searchcontroller.text);
                                    navigateTo(
                                      view: const SearchChatsView(),
                                      context: context,
                                    );
                                    _searchcontroller.clear();
                                  },
                                )),
                                SizedBox(
                                  width: width(20),
                                ),
                                InkWell(
                                  onTap: () {
                                    cubit.getSuggested();
                                    navigateTo(
                                      view: const NewMessageView(),
                                      context: context,
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width(15),
                                      vertical: height(10),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: color.cardColor,
                                      boxShadow: [boxShadow],
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        "assets/icons/send-message.svg",
                                        color: color.primaryColorDark,
                                        width: width(22),
                                        height: height(22),
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height(30),
                          ),
                          Expanded(
                            child: StreamBuilder<List<ChatRoom>>(
                                stream: cubit.getRooms(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    );
                                  }
                                  if (snapshot.data!.isEmpty) {
                                    return const EmptyWidget(
                                      title: "No recent chat",
                                      subTitle: "Direct messages appear here",
                                    );
                                  }
                                  return ListView.separated(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        ChatRoomWidget(
                                      roomModel: snapshot.data![index],
                                      onDissmiss: (DismissDirection direction) {
                                        cubit.deleteChatRoom(
                                          roomId: snapshot.data![index].roomId,
                                        );
                                      },
                                    ),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      height: height(15),
                                    ),
                                    itemCount: snapshot.data!.length,
                                  );
                                }),
                          ),
                        ],
                      ))));
        });
  }
}
