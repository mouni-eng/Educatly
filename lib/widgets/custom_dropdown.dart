import 'package:educatly/size_config.dart';
import 'package:educatly/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown(
      {super.key,
      required this.items,
      required this.onChanged,
      required this.hintText,
      this.label,
      this.prefix,
      this.suffix});

  final List<DropdownMenuItem<dynamic>> items;
  final void Function(dynamic) onChanged;
  final String? hintText, label;
  final Widget? prefix, suffix;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return DropdownButtonFormField(
      iconEnabledColor: color.primaryColorDark.withOpacity(0.25),
      items: items,
      onChanged: onChanged,
      isExpanded: true,
      alignment: Alignment.center,
      validator: (value) {
        if (value == null) {
          return "Enter your $hintText";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        isDense: true,
        hintText: hintText,
        fillColor: color.cardColor,
        filled: true,
        errorStyle: const TextStyle(
          height: 0,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        counterText: "",
        focusColor: Colors.transparent,
        prefixIcon: prefix,
        suffixIcon: suffix,
        contentPadding: EdgeInsets.only(
          right: width(25),
          top: height(15),
          bottom: height(15),
          left: width(25),
        ),
        hintStyle: TextStyle(
          fontSize: width(16),
          color: color.primaryColorDark.withOpacity(0.25),
        ),
        labelStyle: TextStyle(
          color: color.hintColor,
          fontSize: width(14),
        ),
        alignLabelWithHint: true,
        floatingLabelStyle: TextStyle(
          color: color.primaryColor,
          fontSize: width(18),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: color.primaryColor,
          ),
        ),
      ),
      dropdownColor: color.primaryColorLight,
      hint: hintText != null
          ? Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                fontSize: width(16),
                text: hintText!,
                color: color.primaryColorDark.withOpacity(0.25),
              ))
          : null,
      style: TextStyle(
        color: color.primaryColorDark.withOpacity(0.25),
        fontSize: width(16),
      ),
    );
  }
}
