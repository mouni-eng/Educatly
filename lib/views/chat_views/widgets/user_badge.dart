import 'package:educatly/size_config.dart';
import 'package:educatly/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class UserBadge extends StatelessWidget {
  const UserBadge({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width(16),
        vertical: height(8),
      ),
      decoration: BoxDecoration(
        color: color.primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: CustomText(
        fontSize: width(14),
        text: label,
        height: 1.5,
        color: color.primaryColorLight,
      ),
    );
  }
}