import 'package:educatly/constants.dart';
import 'package:flutter/material.dart';
import 'package:educatly/size_config.dart';
import 'package:educatly/widgets/custom_text.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.onTap,
  });

  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);

    return Row(
      children: [
        GestureDetector(
          onTap: onTap ??
              () {
                Navigator.pop(context);
              },
          child: Container(
            padding: padding / 3,
            decoration: BoxDecoration(
              border: Border.all(
                color: color.primaryColorDark.withOpacity(0.25),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: color.primaryColorDark.withOpacity(0.5),
              size: 20,
            ),
          ),
        ),
        SizedBox(
          width: width(10),
        ),
        CustomText(
          fontSize: width(18),
          text: title,
          color: color.primaryColorDark.withOpacity(0.5),
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
