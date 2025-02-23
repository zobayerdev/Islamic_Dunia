// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../constants/text_font_style.dart';
// import '../gen/colors.gen.dart';

// Widget customButton(
//     {required String name,
//     required VoidCallback onCallBack,
//     double? height,
//     double? minWidth,
//     double? borderRadius,
//     Color? color,
//     padding,
//     TextStyle? textStyle,
//     required BuildContext context,
//     Color? borderColor,
//     elevation}) {
//   return GestureDetector(
//     onTap: onCallBack,
//     child: Container(
//       height: height ?? 62.h,
//       width: minWidth ?? double.infinity,
//       padding: padding ?? EdgeInsets.all(0),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//           color: color ?? AppColors.c6940C9,
//           borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
//           border: Border.all(
//             color: borderColor ?? AppColors.c0A5B55,
//           )),
//       child: Text(
//         name,
//         overflow: TextOverflow.ellipsis,
//         style: textStyle ??
//             TextFontStyle.textStyle16c171717Popinsw500
//                 .copyWith(color: AppColors.cFFFFFF),
//       ),
//     ),
//   );
// }

import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:islamic_dunia/assets_helper/app_fonts.dart';

Widget customButton({
  required String name,
  required VoidCallback? onCallBack, // Allow null for safety
  double? height,
  double? minWidth,
  double? borderRadius,
  Color? color,
  padding,
  TextStyle? textStyle,
  required BuildContext context,
  Color? borderColor,
  elevation,
}) {
  return GestureDetector(
    onTap: onCallBack ?? () {}, // Provide a fallback if null
    child: Container(
      height: height ?? 62,
      width: minWidth ?? double.infinity,
      padding: padding ?? EdgeInsets.all(0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color ?? AppColors.c6940C9,
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
        border: Border.all(
          color: borderColor ?? AppColors.c0A5B55,
        ),
      ),
      child: Text(
        name,
        overflow: TextOverflow.ellipsis,
        style: textStyle ??
            TextFontStyle.textStyle16w700Poppins
                .copyWith(color: AppColors.cFFFFFF),
      ),
    ),
  );
}
