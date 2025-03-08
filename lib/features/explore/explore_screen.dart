// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:islamic_dunia/assets_helper/app_fonts.dart';
import 'package:islamic_dunia/assets_helper/app_icons.dart';
import 'package:islamic_dunia/assets_helper/app_images.dart';
import 'package:islamic_dunia/helpers/all_routes.dart';
import 'package:islamic_dunia/helpers/navigation_service.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.cDCE4E6.withOpacity(0.9),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "'Let/s explore the Islamic world'",
                      style: TextFontStyle.headLine22w500Poppins.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage(AppImages.explorebg),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            AppColors.primaryColor.withOpacity(0.9),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              AppIcons.quran,
                              height: 50,
                              width: 50,
                              color: AppColors.white,
                            ),
                            Text(
                              "Hadis of the day",
                              style:
                                  TextFontStyle.textStyle16w600Poppins.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'قال رسول الله صلى الله عليه وسلم:" من لا يَفعَل الخير للناس فهو من أسوأ الناس عند الله."',
                              style:
                                  TextFontStyle.textStyle16w600Poppins.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              NavigationService.navigateTo(
                                Routes.hadisDetailsScreen,
                              );
                            },
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      AppIcons.hadis,
                                      height: 30,
                                      width: 30,
                                      color: AppColors.primaryColor,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "হাদিস সমূহ",
                                      style: TextFontStyle
                                          .textLine12w500Kalpurush
                                          .copyWith(
                                        color: AppColors.primaryColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              NavigationService.navigateTo(
                                Routes.duaDetailsScreen,
                              );
                            },
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      AppIcons.dua,
                                      height: 30,
                                      width: 30,
                                      color: AppColors.primaryColor,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "দোয়া সমূহ",
                                      style: TextFontStyle
                                          .textLine12w500Kalpurush
                                          .copyWith(
                                        color: AppColors.primaryColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              //NavigationService.navigateTo(Routes.surahScreen);
                            },
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      AppIcons.book,
                                      height: 24,
                                      width: 24,
                                      color: AppColors.primaryColor,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "ইসলামিক বুক",
                                      style: TextFontStyle
                                          .textLine12w500Kalpurush
                                          .copyWith(
                                        color: AppColors.primaryColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.allah,
                                    height: 30,
                                    width: 30,
                                    color: AppColors.primaryColor,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "আসমাউল হুসনা",
                                    style: TextFontStyle.textLine12w500Kalpurush
                                        .copyWith(
                                      color: AppColors.primaryColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              NavigationService.navigateTo(Routes.surahScreen);
                            },
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      AppIcons.surah,
                                      height: 30,
                                      width: 30,
                                      color: AppColors.primaryColor,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "সূরা সমূহ",
                                      style: TextFontStyle
                                          .textLine12w500Kalpurush
                                          .copyWith(
                                        color: AppColors.primaryColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.audio,
                                    height: 24,
                                    width: 24,
                                    color: AppColors.primaryColor,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "অডিও সূরা",
                                    style: TextFontStyle.textLine12w500Kalpurush
                                        .copyWith(
                                      color: AppColors.primaryColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.kaaba,
                                    height: 30,
                                    width: 30,
                                    color: AppColors.primaryColor,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "হাজ্জ ও উমরাহ",
                                    style: TextFontStyle.textLine12w500Kalpurush
                                        .copyWith(
                                      color: AppColors.primaryColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.donate,
                                    height: 22,
                                    width: 22,
                                    color: AppColors.primaryColor,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "যাকাত ও সাদাকা",
                                    style: TextFontStyle.textLine12w500Kalpurush
                                        .copyWith(
                                      color: AppColors.primaryColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.ramzan,
                                    height: 22,
                                    width: 22,
                                    color: AppColors.primaryColor,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "রমাদান ক্যালেন্ডার",
                                    style: TextFontStyle.textLine12w500Kalpurush
                                        .copyWith(
                                      color: AppColors.primaryColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.wallpaper,
                                    height: 22,
                                    width: 22,
                                    color: AppColors.primaryColor,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "ইসলামিক ওয়ালপেপার",
                                    style: TextFontStyle.textLine12w500Kalpurush
                                        .copyWith(
                                      color: AppColors.primaryColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.prayer,
                                    height: 30,
                                    width: 30,
                                    color: AppColors.primaryColor,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "নামাযের নিয়মাবলী",
                                    style: TextFontStyle.textLine12w500Kalpurush
                                        .copyWith(
                                      color: AppColors.primaryColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.upcoming,
                                    height: 30,
                                    width: 30,
                                    color: AppColors.primaryColor,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "আপকামিং ইভেন্ট",
                                    style: TextFontStyle.textLine12w500Kalpurush
                                        .copyWith(
                                      color: AppColors.primaryColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
