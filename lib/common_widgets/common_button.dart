import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:islamic_dunia/assets_helper/app_fonts.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String? imagePath;
  final String label;
  final color;
  final borderColor;
  final textColor;
  final imageColor;
  final VoidCallback onPressed;

  const CommonButton({
    Key? key,
    this.imagePath,
    required this.label,
    this.color,
    required this.onPressed,
    this.borderColor,
    this.textColor,
    this.imageColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 56,
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: color ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: borderColor ?? AppColors.primaryColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath != null)
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: Image.asset(
                  imagePath!,
                  height: 20,
                  width: 20,
                  color: imageColor ?? Colors.white,
                ),
              ),
            Text(
              label,
              style: TextFontStyle.textStyle16w400Poppins.copyWith(
                color: textColor ?? Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//
