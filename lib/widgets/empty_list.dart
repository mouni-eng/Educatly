import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:educatly/size_config.dart';
import 'package:educatly/widgets/custom_text.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/empty.svg",
            width: width(100),
            height: height(100),
          ),
          SizedBox(
            height: height(25),
          ),
          CustomText(
            fontSize: width(16),
            text: "No Results",
            color: color.primaryColor,
          ),
        ],
      ),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title, subTitle;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: height(15),
        ),
        SvgPicture.asset(
          "assets/images/empty.svg",
          width: width(100),
          height: height(100),
        ),
        SizedBox(
          height: height(25),
        ),
        CustomText(
          align: TextAlign.center,
          fontSize: width(14),
          maxlines: 2,
          text: title,
          color: color.primaryColor,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(
          height: height(5),
        ),
        CustomText(
          align: TextAlign.center,
          fontSize: width(12),
          maxlines: 2,
          text: subTitle,
          color: color.hintColor,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
