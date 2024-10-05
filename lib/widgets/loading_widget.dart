import 'package:educatly/size_config.dart';
import 'package:educatly/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var color = Theme.of(context);
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                "assets/images/logo.jpg",
                width: width(50),
                height: height(50),
              ),
            ),
            SizedBox(
              height: height(15),
            ),
            CustomText(
              fontSize: width(15),
              text: "Loading..",
              fontWeight: FontWeight.w600,
              color: color.primaryColor,
            ),
          ],
        ),
      )),
    );
  }
}
