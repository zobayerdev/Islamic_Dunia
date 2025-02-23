import 'package:flutter/material.dart';
import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:islamic_dunia/assets_helper/app_fonts.dart';
import '../helpers/navigation_service.dart';

class ReusableAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final bool centerTitle;
  final PreferredSizeWidget? bottom;

  const ReusableAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.actions,
    this.centerTitle = true,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: centerTitle,
      leading: showBackButton
          ? IconButton(
              onPressed: () {
                NavigationService.goBackCall();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.c394456,
                size: 18,
              ),
            )
          : null,
      title: Text(
        title,
        style: TextFontStyle.textStyle14w400Poppins,
      ),
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
