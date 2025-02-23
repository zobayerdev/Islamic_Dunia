import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:flutter/material.dart';

final class UIHelper {
  UIHelper._();

  // Helper functions to calculate dimensions dynamically using MediaQuery
  static double _getWidth(BuildContext context, double fraction) {
    return MediaQuery.of(context).size.width * fraction;
  }

  static double _getHeight(BuildContext context, double fraction) {
    return MediaQuery.of(context).size.height * fraction;
  }

  // Flexible horizontal and vertical spacing
  static Widget horizontalSpace(BuildContext context, double fraction) =>
      SizedBox(width: _getWidth(context, fraction));
  static Widget verticalSpace(BuildContext context, double fraction) =>
      SizedBox(height: _getHeight(context, fraction));

  // Customizable sizes
  static double borderRadius(BuildContext context, double fraction) =>
      _getWidth(context, fraction);

  static double iconSize(BuildContext context, double fraction) =>
      _getWidth(context, fraction);

  static double fontSize(BuildContext context, double fraction) =>
      _getWidth(context, fraction);

  // Example pre-defined sizes
  static double smallBorderRadius(BuildContext context) =>
      borderRadius(context, 0.02); // 2% of screen width
  static double mediumBorderRadius(BuildContext context) =>
      borderRadius(context, 0.04); // 4% of screen width
  static double largeBorderRadius(BuildContext context) =>
      borderRadius(context, 0.08); // 8% of screen width

  static double smallIconSize(BuildContext context) =>
      iconSize(context, 0.05); // 5% of screen width
  static double mediumIconSize(BuildContext context) =>
      iconSize(context, 0.08); // 8% of screen width
  static double largeIconSize(BuildContext context) =>
      iconSize(context, 0.12); // 12% of screen width

  static double smallFontSize(BuildContext context) =>
      fontSize(context, 0.03); // 3% of screen width
  static double mediumFontSize(BuildContext context) =>
      fontSize(context, 0.05); // 5% of screen width
  static double largeFontSize(BuildContext context) =>
      fontSize(context, 0.07); // 7% of screen width

  // Padding and margin
  static EdgeInsets defaultPadding(BuildContext context) =>
      EdgeInsets.all(_getWidth(context, 0.05)); // 5% of screen width

  static EdgeInsets symmetricPadding(BuildContext context,
          double verticalFraction, double horizontalFraction) =>
      EdgeInsets.symmetric(
        vertical: _getHeight(context, verticalFraction),
        horizontal: _getWidth(context, horizontalFraction),
      );

  static EdgeInsets onlyPadding(BuildContext context,
          {double? top, double? bottom, double? left, double? right}) =>
      EdgeInsets.only(
        top: top != null ? _getHeight(context, top) : 0,
        bottom: bottom != null ? _getHeight(context, bottom) : 0,
        left: left != null ? _getWidth(context, left) : 0,
        right: right != null ? _getWidth(context, right) : 0,
      );

  //Divider
  static Widget customDivider(BuildContext context) => Container(
        height: 0.006 * MediaQuery.of(context).size.height, // 0.6% of height
        color: AppColors.c444444,
        width: double.infinity,
      );
}