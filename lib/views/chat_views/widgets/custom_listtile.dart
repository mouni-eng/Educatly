import 'package:educatly/infrastructure/utils.dart';
import 'package:educatly/size_config.dart';
import 'package:educatly/widgets/circle_image.dart';
import 'package:educatly/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    required this.isSelected,
    this.onChanged,
    this.image,
  });

  final String? title, image;
  final bool isSelected;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Column(
      children: [
        CheckboxListTile.adaptive(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          dense: true,
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          side: BorderSide(color: color.primaryColorDark),
          title: Row(
            children: [
              if (image != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: BorderImage(
                    imageSrc: image,
                    avatarLetters: NameUtil.getInitials(title, title),
                    cawidth: width(50),
                    caheight: height(50),
                  ),
                ),
                SizedBox(
                  width: width(15),
                ),
              ],
              CustomText(
                fontSize: width(16),
                text: title!,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          value: isSelected,
          checkColor: color.primaryColorLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          activeColor: color.primaryColor,
          onChanged: onChanged,
        ),
        SizedBox(
          height: height(10),
        ),
        const Divider(),
      ],
    );
  }
}
