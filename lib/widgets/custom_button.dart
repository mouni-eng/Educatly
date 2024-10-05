import 'package:educatly/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:educatly/size_config.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final double? btnWidth, btnHeight, radius, fontSize;
  final bool? isUpperCase, showLoader, enabled;
  final String? text, svgLeadingIcon;
  final Color? background, textColor;
  final Function()? function;
  final FontWeight? fontWeight;

  const CustomButton({
    super.key,
    this.btnWidth = double.infinity,
    this.background,
    this.radius = 8.0,
    required this.fontSize,
    this.isUpperCase = false,
    required this.function,
    required this.text,
    this.svgLeadingIcon,
    this.showLoader = false,
    this.btnHeight = 60,
    this.enabled = true,
    this.fontWeight,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    var bg = background ?? Theme.of(context).primaryColor;
    return Container(
      width: btnWidth,
      height: height(btnHeight!),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius!,
        ),
        color: showLoader! || !enabled! ? bg.withOpacity(0.3) : bg,
      ),
      child: MaterialButton(
          onPressed: showLoader! || !enabled! ? null : function,
          child: _rowWidget(context)),
    );
  }

  Widget _rowWidget(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (svgLeadingIcon != null) ...[
          SvgPicture.asset(
            svgLeadingIcon!,
          ),
          SizedBox(
            width: width(14),
          ),
        ],
        if (showLoader!)
          SizedBox(
              width: height(btnHeight! * 0.7),
              height: height(btnHeight! * 0.7),
              child: const CircularProgressIndicator.adaptive()),
        if (showLoader!)
          SizedBox(
            width: width(14),
          ),
        _textWidget(context),
      ],
    );
  }

  Widget _textWidget(context) {
    return Expanded(
        child: Center(
      child: CustomText(
        text: isUpperCase! ? text!.toUpperCase() : text!,
        color: textColor ?? Colors.white,
        fontWeight: fontWeight ?? FontWeight.w600,
        fontSize: fontSize!,
      ),
    ));
  }
}

class CustomNextButton extends StatelessWidget {
  const CustomNextButton(
      {super.key, this.background, required this.function, this.icon});

  final Color? background;
  final void Function() function;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    var bg = Theme.of(context);
    return Container(
      width: width(45),
      height: height(45),
      decoration: BoxDecoration(
        shape: icon == null ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: icon != null ? BorderRadius.circular(8) : null,
        color: background ?? bg.primaryColor,
      ),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: function,
        child: icon == null
            ? Center(
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: bg.scaffoldBackgroundColor,
                  size: 16,
                ),
              )
            : SvgPicture.asset(
                "assets/icons/$icon.svg",
                width: width(25),
                height: height(25),
                color: bg.primaryColorLight,
              ),
      ),
    );
  }
}

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: height(18),
          horizontal: width(16),
        ),
        decoration: BoxDecoration(
          color: color.primaryColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: color.primaryColorDark,
        ),
      ),
    );
  }
}

class CustomBookMarkWidget extends StatelessWidget {
  const CustomBookMarkWidget(
      {super.key, required this.onTap, this.isFavourite = false});

  final Function() onTap;
  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: color.primaryColorLight,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [boxShadow],
          ),
          child: SvgPicture.asset(
            "assets/icons/bookmark.svg",
            width: width(22),
            height: height(22),
            color: color.primaryColorDark,
          )),
    );
  }
}

class CustomBackWidget extends StatelessWidget {
  const CustomBackWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: color.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [boxShadow],
          ),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: color.primaryColorDark,
            size: 20,
          ),
        ));
  }
}
