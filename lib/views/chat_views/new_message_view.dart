import 'package:educatly/constants.dart';
import 'package:educatly/size_config.dart';
import 'package:educatly/view_models/chat_cubit/cubit.dart';
import 'package:educatly/view_models/chat_cubit/states.dart';
import 'package:educatly/views/chat_views/chat_view.dart';
import 'package:educatly/views/chat_views/widgets/custom_listtile.dart';
import 'package:educatly/views/chat_views/widgets/user_badge.dart';
import 'package:educatly/widgets/custom_app_bar.dart';
import 'package:educatly/widgets/custom_list_widget.dart';
import 'package:educatly/widgets/custom_navigation.dart';
import 'package:educatly/widgets/custom_text.dart';
import 'package:educatly/widgets/empty_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewMessageView extends StatelessWidget {
  const NewMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    final TextEditingController searchcontroller = TextEditingController();
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomAppBar(
                        title: "New message",
                        onTap: () {
                          Navigator.pop(context);
                          cubit.userToChat = null;
                        },
                      ),
                      InkWell(
                        onTap: () {
                          if (cubit.userToChat != null) {
                            navigateTo(
                              view: ChatDetailsView(
                                recieverId: cubit.userToChat!.personalId!,
                              ),
                              context: context,
                            );
                          }
                        },
                        child: CustomText(
                          fontSize: width(16),
                          text: "Chat",
                          fontWeight: FontWeight.w600,
                          color: cubit.userToChat != null
                              ? color.primaryColor
                              : color.hintColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height(20),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        fontSize: width(16),
                        text: "To",
                        fontWeight: FontWeight.w600,
                      ),
                      TextFormField(
                        controller: searchcontroller,
                        onChanged: (value) {
                          cubit.searchSuggested(query: value);
                        },
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(
                            color: color.hintColor,
                            fontSize: width(16),
                          ),
                          alignLabelWithHint: true,
                          label: cubit.userToChat != null
                              ? UserBadge(
                                  label: cubit.userToChat!.getFullName(),
                                )
                              : CustomText(
                                  fontSize: width(16),
                                  text: "Search",
                                  color: color.hintColor,
                                ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 0,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: color.colorScheme.tertiary,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: color.colorScheme.tertiary,
                            ),
                          ),
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: color.colorScheme.tertiary,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: color.primaryColor,
                            ),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: width(16),
                          color: color.hintColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height(30),
                  ),
                  Expanded(
                    child: ListLoadingBuilder(
                      condition: state is! SearchSuggestedLoadingState,
                      itemCount: cubit.users.length,
                      itemBuilder: (context, index) => CustomListTile(
                        onChanged: (value) {
                          cubit.setUser(userModel: cubit.users[index]);
                          if (searchcontroller.text.isNotEmpty) {
                            searchcontroller.clear();
                            cubit.getSuggested();
                          }
                        },
                        title: cubit.users[index].getFullName(),
                        isSelected: cubit.userToChat?.personalId ==
                            cubit.users[index].personalId,
                        image: cubit.users[index].profilePictureId ?? "",
                      ),
                      fallback: const EmptyWidget(
                        title: "No recent users",
                        subTitle: "All Suggested users appear here",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
