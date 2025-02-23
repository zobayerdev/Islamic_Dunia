import 'package:flutter/widgets.dart';

final class IconHolder extends StatelessWidget {
  final Color bgColor;
  final Color iconColor;
  final IconData icon;
  final double? size;
  final double? height;
  final double? width;
  final double? weight;

  const IconHolder({
    super.key,
    this.size,
    this.height = 36,
    this.width = 36,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height!,
      width: width!,
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.all(Radius.circular(8),),),
      child: Icon(
        icon,
        size: size,
        color: iconColor,
        weight: weight,
      ),
    );
  }
}
