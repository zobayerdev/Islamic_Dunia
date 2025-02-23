import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget AuthCustomeButton({
  required String name,
  required VoidCallback onCallBack,
  required double height,
  required double minWidth,
  required double borderRadius,
  required Color color,
  required TextStyle textStyle,
  required BuildContext context,
  Color? borderColor,
}) {
  return MaterialButton(
    onPressed: onCallBack,
    elevation: 0,
    height: height,
    minWidth: minWidth,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    color: color,
    splashColor: Colors.white.withOpacity(0.4),
    child: Text(
      name,
      style: textStyle,
    ),
  );
}
