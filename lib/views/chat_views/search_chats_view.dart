import 'package:educatly/constants.dart';
import 'package:educatly/size_config.dart';
import 'package:educatly/view_models/chat_cubit/cubit.dart';
import 'package:educatly/view_models/chat_cubit/states.dart';
import 'package:educatly/views/chat_views/widgets/chat_room_widget.dart';
import 'package:educatly/widgets/custom_app_bar.dart';
import 'package:educatly/widgets/custom_list_widget.dart';
import 'package:educatly/widgets/empty_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchChatsView extends StatelessWidget {
  const SearchChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ChatCubit cubit = ChatCubit.get(context);
        return Scaffold(
          body: SafeArea(
              child: Padding(
            padding: padding,
            child: Column(
              children: [
                const CustomAppBar(
                  title: "Search Results",
                ),
                SizedBox(
                  height: height(25),
                ),
                Expanded(
                  child: ListLoadingBuilder(
                    condition: state is! SearchChatLoadingState,
                    itemCount: cubit.chatRooms.length,
                    itemBuilder: (context, index) => ChatRoomWidget(
                      roomModel: cubit.chatRooms[index],
                      onDissmiss: (DismissDirection direction) {
                        cubit.deleteChatRoom(
                          roomId: cubit.chatRooms[index].roomId,
                        );
                      },
                    ),
                    fallback: const EmptyWidget(
                      title: "There is no matching chat rooms",
                      subTitle:
                          "Chats you start with matching search will appear here",
                    ),
                  ),
                ),
              ],
            ),
          )),
        );
      },
    );
  }
}
