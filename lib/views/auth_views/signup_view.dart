import 'package:educatly/constants.dart';
import 'package:educatly/infrastructure/enums.dart';
import 'package:educatly/services/alert_service.dart';
import 'package:educatly/view_models/settings_cubit/cubit.dart';
import 'package:educatly/views/chat_views/messages_view.dart';
import 'package:educatly/widgets/circle_image.dart';
import 'package:educatly/widgets/custom_dropdown.dart';
import 'package:educatly/widgets/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:educatly/infrastructure/utils.dart';
import 'package:educatly/size_config.dart';
import 'package:educatly/view_models/auth_cubit/cubit.dart';
import 'package:educatly/view_models/auth_cubit/states.dart';
import 'package:educatly/widgets/custom_app_bar.dart';
import 'package:educatly/widgets/custom_button.dart';
import 'package:educatly/widgets/custom_formField.dart';
import 'package:educatly/widgets/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
      if (state is RegisterSuccessState) {
        SettingCubit.get(context).getUser();
        navigateTo(
          view: const MessagesView(),
          context: context,
        );
      } else if (state is RegisterErrorState) {
        AlertService.showSnackbarAlert(
          state.error.toString(),
          SnackbarType.error,
          context,
        );
      }
    }, builder: (context, state) {
      AuthCubit cubit = AuthCubit.get(context);
      return Scaffold(
        body: SafeArea(
            child: Padding(
          padding: padding,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: cubit.registerFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomAppBar(
                    title: "Sign up",
                  ),
                  SizedBox(
                    height: height(25),
                  ),
                  ProfilePictureWidget(
                    profileImage: cubit.profileImage,
                    onPickImage: (value) {
                      cubit.chooseImage(value);
                    },
                    profileImageUrl: cubit.signUpRequest.profilePictureId,
                  ),
                  SizedBox(
                    height: height(23),
                  ),
                  CustomFormField(
                    onChange: (value) {
                      cubit.onChangeFirstName(value);
                    },
                    hintText: "First Name",
                  ),
                  SizedBox(
                    height: height(15),
                  ),
                  CustomFormField(
                    onChange: (value) {
                      cubit.onChangeLastName(value);
                    },
                    hintText: "Last Name",
                  ),
                  SizedBox(
                    height: height(15),
                  ),
                  CustomFormField(
                    type: TextInputType.emailAddress,
                    validate: (value) => Validate.validateEmail(value),
                    onChange: (value) {
                      cubit.onChangeEmailAddress(value);
                    },
                    hintText: "Email",
                  ),
                  SizedBox(
                    height: height(15),
                  ),
                  CustomDropDown(
                    items: Gender.values.map((Gender gender) {
                      return DropdownMenuItem<Gender>(
                        value: gender,
                        child: CustomText(
                          text: gender.name,
                          fontSize: width(16),
                          color: color.primaryColorDark.withOpacity(0.25),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      cubit.onChangeGender(value);
                    },
                    hintText: 'Gender',
                  ),
                  SizedBox(
                    height: height(15),
                  ),
                  CustomFormField(
                    isPassword: true,
                    validate: (value) => Validate.validatePassword(value),
                    onChange: (value) {
                      cubit.onChangePassword(value);
                    },
                    hintText: "Password",
                  ),
                  SizedBox(
                    height: height(50),
                  ),
                  CustomButton(
                    showLoader: state is RegisterLoadingState,
                    fontSize: width(17),
                    function: () async {
                      if (cubit.registerFormKey.currentState!.validate()) {
                        cubit.saveUser();
                      }
                    },
                    text: "Sign Up",
                  ),
                  SizedBox(
                    height: height(30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        fontSize: width(15),
                        text: "Already have an account?",
                        color: color.primaryColorDark.withOpacity(0.5),
                      ),
                      SizedBox(
                        width: width(5),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CustomText(
                          fontSize: width(15),
                          text: "Log In",
                          color: color.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )),
      );
    });
  }
}
