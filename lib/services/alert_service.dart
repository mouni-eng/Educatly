import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:educatly/constants.dart';
import 'package:educatly/size_config.dart';
import 'package:educatly/widgets/custom_text.dart';

enum SnackbarType { success, warning, error }

class ErrorService {
  static String defineError(error) {
    return 'error';
  }
}

class AlertService {
  static showSnackbarAlert(String strAlert, SnackbarType type, context) {
    var color = Theme.of(context);
    Flushbar flushbar = Flushbar();
    flushbar = Flushbar(
      padding: EdgeInsets.symmetric(
        horizontal: width(16),
        vertical: height(16),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: width(16),
        vertical: height(16),
      ),
      boxShadows: [boxShadow],
      borderRadius: BorderRadius.circular(16),
      backgroundColor: color.scaffoldBackgroundColor,
      titleText: type.index == 2
          ? CustomText(
              fontSize: width(16),
              text: strAlert,
              fontWeight: FontWeight.w600,
            )
          : CustomText(
              fontSize: width(16),
              text: type.name,
              fontWeight: FontWeight.w600,
            ),
      messageText: CustomText(
        color: color.primaryColorDark.withOpacity(0.5),
        fontSize: width(14),
        maxlines: 3,
        text: strAlert,
      ),
      icon: SvgPicture.asset("assets/icons/${type.name}.svg"),
      mainButton: GestureDetector(
        onTap: () {
          flushbar.dismiss();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width(16),
          ),
          child: SvgPicture.asset("assets/icons/exit.svg"),
        ),
      ),
    );
    flushbar.show(context);
  }
}
