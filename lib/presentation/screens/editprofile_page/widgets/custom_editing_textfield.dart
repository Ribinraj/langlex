import 'package:flutter/material.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';


class CustomEditingTextfield extends StatelessWidget {
  const CustomEditingTextfield({
    super.key,
    required this.controller,
    this.labelText,
    this.textInputType,
    this.validator,
    this.suffixIcon,
    this.obscureText,
  });

  final TextEditingController controller;
  final String? labelText;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Appcolors.kgreenColor,
      validator: validator,
      controller: controller,
      obscureText: obscureText ?? false,
      keyboardType: textInputType,
      style: const TextStyle(
        fontSize: 15,
      ),
      decoration: InputDecoration(
          fillColor: Appcolors.kwhiteColor,
          filled: true,
          border: InputBorder.none,
          isDense: true,
          errorMaxLines: 3,
          suffixIcon: suffixIcon,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          labelText: labelText,
          labelStyle: const TextStyle(
              color: Appcolors.khinttextColor,
              fontWeight: FontWeight.bold,
              fontSize: 16),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadiusStyles.kradius10(),
              borderSide:
                  BorderSide(color: Appcolors.kgreenColor.withOpacity(.4))),
          focusedBorder: OutlineInputBorder(
              borderRadius:BorderRadiusStyles.kradius10(),
              borderSide:
                  const BorderSide(color: Appcolors.kgreenColor, width: 1.5)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadiusStyles.kradius10(),
              borderSide:
                  const BorderSide(color: Appcolors.kredcolor, width: 1.5)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadiusStyles.kradius30(),
              borderSide:
                  const BorderSide(color: Appcolors.kredcolor, width: 1.5))),
    );
  }
}
