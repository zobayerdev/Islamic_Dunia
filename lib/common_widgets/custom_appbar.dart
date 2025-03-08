import 'package:islamic_dunia/assets_helper/app_colors.dart';
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
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SvgPicture.asset(
                    AppIcons.backSvg,
                    height: 16,
                    width: 16,
                  ),
                ),
              ),
            ),
      backgroundColor: AppColors.cDCE4E6.withOpacity(0.9),
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
