import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
final class CustomNumberFormField extends StatelessWidget {
  String? hintText;
  final String labelText;
  TextEditingController textEditingController;
  final TextInputType inputType;
  double? fieldHeight;
  int? maxline;
  final String? Function(String?)? validator;
  bool? validation;
  CustomNumberFormField(
      {super.key,
      this.hintText,
      required this.labelText,
      required this.textEditingController,
      required this.inputType,
      this.fieldHeight,
      this.maxline,
      this.validator,
      this.validation = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: fieldHeight ?? 35,
      child: TextFormField(
        cursorHeight: 20.0,
        autovalidateMode: validation! ? AutovalidateMode.always : AutovalidateMode.disabled,
        validator: validator,
        maxLines: maxline ?? 1,
        controller: textEditingController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 20),
          hintText: hintText,
          hintStyle: TextStyle(
            letterSpacing: 1,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            color: AppColors.c9B9B9B,
          ),
          //labelText: labelText,
          labelStyle: TextStyle(
            letterSpacing: 1,
            fontSize: 14,
            fontWeight: FontWeight.w100,
            fontStyle: FontStyle.normal,
            color: AppColors.c9B9B9B,
          ),
          errorStyle: TextStyle(
            letterSpacing: 1,
            fontSize: 14,
            fontWeight: FontWeight.w100,
            fontStyle: FontStyle.normal,
            color: Colors.red,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.0),
            borderSide: const BorderSide(
              color: AppColors.c9B9B9B,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.0),
            borderSide: const BorderSide(
              color: AppColors.c9B9B9B,
              width: 1.5,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: AppColors.c9B9B9B,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.0),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.0),
            borderSide: const BorderSide(
              color: AppColors.c9B9B9B,
              width: 1.5,
            ),
          ),
        ),
        style: TextStyle(
          letterSpacing: 1.5,
          fontSize: 18,
          fontWeight: FontWeight.w100,
          fontStyle: FontStyle.normal,
          color: AppColors.c9B9B9B,
        ),
        keyboardType: inputType,
      ),
    );
  }
}
