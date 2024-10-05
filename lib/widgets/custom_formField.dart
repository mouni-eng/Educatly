import 'package:flutter/material.dart';
import 'package:educatly/size_config.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? type;
  final void Function(String)? onSubmit;
  final void Function(String)? onChange;
  final void Function()? onTap;
  final bool isPassword;
  final String? Function(String?)? validate;
  final String? label;
  final int? maxLines;
  final String? hintText;
  final int? maxLength;
  final Widget? prefix;
  final bool isAboutMe;
  final Widget? suffix;
  final bool isClickable;
  final Color? fillColor;

  const CustomFormField({
    super.key,
    this.hintText,
    this.controller,
    this.isClickable = true,
    this.isPassword = false,
    this.label,
    this.maxLength,
    this.isAboutMe = false,
    this.maxLines = 1,
    this.onChange,
    this.onSubmit,
    this.onTap,
    this.prefix,
    this.suffix,
    this.type,
    this.validate,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return TextFormField(
      maxLength: maxLength,
      maxLines: maxLines,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      textAlignVertical: TextAlignVertical.center,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      validator: validate ??
          (value) {
            if (value!.isEmpty) {
              return "Enter your $hintText";
            }
            return null;
          },
      decoration: InputDecoration(
        labelText: label,
        isDense: true,
        hintText: hintText,
        fillColor: fillColor ?? color.cardColor,
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
        alignLabelWithHint: false,
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
        disabledBorder: OutlineInputBorder(
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
      style: TextStyle(
        color: color.primaryColorDark.withOpacity(0.25),
        fontSize: width(16),
      ),
    );
  }
}
