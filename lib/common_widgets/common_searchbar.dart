import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:islamic_dunia/assets_helper/app_images.dart';
import 'package:flutter/material.dart';
import 'package:islamic_dunia/assets_helper/app_fonts.dart';


class CommonSearchBar extends StatelessWidget {
  const CommonSearchBar({
    super.key,
    this.controller,
    this.onSubmitted,
    this.hintText,
  });

  final TextEditingController? controller;
  final onSubmitted;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onSubmitted,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 12),
        hintText: hintText,
        hintStyle: TextFontStyle.textStyle12w400Poppins.copyWith(
          color: AppColors.c5A5C5F,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.all(12.0),
          child: Image.asset(
              height: 14,
              width: 14,
              fit: BoxFit.cover,
              AppImages.searchImage,
              ),
        ),

        border: OutlineInputBorder(),
        // enabledBorder: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor,),
        ),
      ),
    );
  }
}
