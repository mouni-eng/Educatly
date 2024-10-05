import 'package:educatly/infrastructure/utils.dart';
import 'package:educatly/services/alert_service.dart';
import 'package:educatly/size_config.dart';
import 'package:educatly/view_models/auth_cubit/cubit.dart';
import 'package:educatly/view_models/auth_cubit/states.dart';
import 'package:educatly/widgets/custom_app_bar.dart';
import 'package:educatly/widgets/custom_button.dart';
import 'package:educatly/widgets/custom_formField.dart';
import 'package:educatly/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Scaffold(
        body: BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is ResetPasswordErrorState) {
          AlertService.showSnackbarAlert(
              "Email is incorrect!", SnackbarType.error, context);
        } else if (state is ResetPasswordSuccessState) {
          AlertService.showSnackbarAlert(
              "Code Sent!", SnackbarType.success, context);
        }
      },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width(16)),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: height(20),
                    ),
                    const CustomAppBar(title: "Reset Password"),
                    SizedBox(
                      height: height(40),
                    ),
                    SvgPicture.asset(
                      "assets/images/message.svg",
                      width: width(165),
                      height: height(152),
                    ),
                    SizedBox(
                      height: height(100),
                    ),
                    CustomText(
                      text: "Forgot Your Password?",
                      height: 1,
                      color: color.primaryColorDark,
                      fontWeight: FontWeight.w600,
                      fontSize: width(16),
                    ),
                    SizedBox(
                      height: height(30),
                    ),
                    CustomText(
                      text:
                          "To recover your password, you need to enter your registered email address. we will send the\nrecovery code to your email",
                      color: color.primaryColorDark.withOpacity(0.75),
                      fontSize: width(16),
                      align: TextAlign.center,
                      maxlines: 3,
                    ),
                    SizedBox(
                      height: height(80),
                    ),
                    Form(
                      key: cubit.resetFormKey,
                      child: CustomFormField(
                        onChange: (value) {
                          cubit.onChangeResetEmail(value);
                        },
                        type: TextInputType.emailAddress,
                        validate: (value) => Validate.validateEmail(value),
                        hintText: "Email address",
                      ),
                    ),
                    SizedBox(
                      height: height(50),
                    ),
                    CustomButton(
                      showLoader: state is ResetPasswordLoadingState,
                      function: () {
                        if (cubit.resetFormKey.currentState!.validate()) {
                          cubit.resetPassword(
                            
                          );
                        }
                      },
                      text: "Send Link",
                      fontSize: width(16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ));
  }
}