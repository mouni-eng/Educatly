import 'package:educatly/constants.dart';
import 'package:educatly/infrastructure/utils.dart';
import 'package:educatly/services/alert_service.dart';
import 'package:educatly/size_config.dart';
import 'package:educatly/view_models/auth_cubit/cubit.dart';
import 'package:educatly/view_models/auth_cubit/states.dart';
import 'package:educatly/view_models/settings_cubit/cubit.dart';
import 'package:educatly/views/auth_views/forget_password_view.dart';
import 'package:educatly/views/auth_views/signup_view.dart';
import 'package:educatly/views/chat_views/messages_view.dart';
import 'package:educatly/widgets/custom_button.dart';
import 'package:educatly/widgets/custom_formField.dart';
import 'package:educatly/widgets/custom_navigation.dart';
import 'package:educatly/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    SizeConfig().init(context);
    return BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
      if (state is LogInErrorState) {
        AlertService.showSnackbarAlert(
            state.error.toString(), SnackbarType.error, context);
      } else if (state is LogInSuccessState) {
        SettingCubit.get(context).getUser();
        navigateTo(
          view: const MessagesView(),
          context: context,
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
              key: cubit.loginFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height(10),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      "assets/images/logo.jpg",
                      width: width(150),
                      height: height(130),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: height(20),
                  ),
                  CustomText(
                    fontSize: width(20),
                    text: "Welcome Back",
                    color: color.primaryColor,
                  ),
                  SizedBox(
                    height: height(30),
                  ),
                  CustomFormField(
                    validate: (value) => Validate.validateEmail(value),
                    onChange: (value) {
                      cubit.onChangeEmailAddress(value);
                    },
                    hintText: "Email",
                  ),
                  SizedBox(
                    height: height(35),
                  ),
                  CustomFormField(
                    isPassword: true,
                    validate: (value) => Validate.validatePassword(value),
                    onChange: (value) {
                      cubit.onChangePassword(value);
                    },
                    hintText: "Password",
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        navigateTo(
                          view: const ForgetPasswordView(),
                          context: context,
                        );
                      },
                      child: CustomText(
                        fontSize: width(14),
                        text: "Forgot password?",
                        fontWeight: FontWeight.w600,
                        color: color.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height(38),
                  ),
                  CustomButton(
                    showLoader: state is LogInLoadingState,
                    fontSize: width(17),
                    function: () {
                      if (cubit.loginFormKey.currentState!.validate()) {
                        cubit.logIn();
                      }
                    },
                    text: "Sign in",
                  ),
                  SizedBox(
                    height: height(50),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        fontSize: width(15),
                        text: "Dont have account?",
                        color: color.primaryColorDark.withOpacity(0.5),
                      ),
                      SizedBox(
                        width: width(5),
                      ),
                      InkWell(
                        onTap: () {
                          navigateTo(
                            view: const SignUpView(),
                            context: context,
                          );
                        },
                        child: CustomText(
                          fontSize: width(15),
                          text: "Sign Up",
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
