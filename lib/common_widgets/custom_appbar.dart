import 'package:islamic_dunia/assets_helper/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:islamic_dunia/assets_helper/app_fonts.dart';
import '../helpers/navigation_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.onCallBack,
    this.leadingIconUnVisible = false,
    this.actions,
    this.isCenterd = false,
  });

  final String? title;
  final VoidCallback? onCallBack;
  final bool leadingIconUnVisible;
  final List<Widget>? actions;
  final bool isCenterd;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: leadingIconUnVisible
          ? null
          : Padding(
              padding: EdgeInsets.all(14),
              child: InkWell(
                onTap: () {
                  NavigationService.goBack;
                },
                child: SvgPicture.asset(
                  AppIcons.arrowPrevious,
                  height: 28,
                  width: 28,
                ),
              ),
            ),
      backgroundColor: Colors.white,
      centerTitle: isCenterd,
      title: Text(
        title ?? '',
        style: TextFontStyle.textStyle18w600Poppins,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
