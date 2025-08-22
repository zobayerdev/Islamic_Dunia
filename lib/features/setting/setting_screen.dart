import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:islamic_dunia/assets_helper/app_fonts.dart';
import 'package:islamic_dunia/assets_helper/app_icons.dart';
import 'package:islamic_dunia/assets_helper/app_images.dart';
import 'package:islamic_dunia/helpers/all_routes.dart';
import 'package:islamic_dunia/helpers/navigation_service.dart';
import 'package:islamic_dunia/helpers/ui_helpers.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cDCE4E6.withOpacity(0.9),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(UIHelper.kDefaultPadding()),
          child: Column(
            children: [
              Image.asset(
                AppImages.bgImages,
                height: 150,
                width: 150,
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'বিবিধ',
                  style: TextFontStyle.textLine12w500Kalpurush.copyWith(
                    color: Colors.black,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              UIHelper.verticalSpace(10),

              // * Time Corrcetion
              GestureDetector(
                onTap: () {
                  NavigationService.navigateTo(Routes.timeCorrectionScreen);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppIcons.locationIcon,
                              color: AppColors.activeColor,
                              height: 20.h,
                              width: 20.w,
                            ),
                            UIHelper.horizontalSpace(15),
                            Text(
                              'হিজরি সময় সংশোধন',
                              style: TextFontStyle.textLine12w500Kalpurush
                                  .copyWith(
                                color: Colors.black,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        SvgPicture.asset(
                          AppIcons.arrowNextIcon,
                          color: AppColors.activeColor,
                          height: 20.h,
                          width: 20.w,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              UIHelper.verticalSpace(10),

              // * Privacy Policy
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.privacyIcon,
                            color: AppColors.activeColor,
                            height: 20.h,
                            width: 20.w,
                          ),
                          UIHelper.horizontalSpace(15),
                          Text(
                            'গোপনীয়তা নীতি',
                            style:
                                TextFontStyle.textLine12w500Kalpurush.copyWith(
                              color: Colors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      SvgPicture.asset(
                        AppIcons.arrowNextIcon,
                        color: AppColors.activeColor,
                        height: 20.h,
                        width: 20.w,
                      )
                    ],
                  ),
                ),
              ),
              UIHelper.verticalSpace(10),

              // * Terms and Condition
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.privacyIcon,
                            color: AppColors.activeColor,
                            height: 20.h,
                            width: 20.w,
                          ),
                          UIHelper.horizontalSpace(15),
                          Text(
                            'টার্মস অ্যান্ড কন্ডিশনস',
                            style:
                                TextFontStyle.textLine12w500Kalpurush.copyWith(
                              color: Colors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      SvgPicture.asset(
                        AppIcons.arrowNextIcon,
                        color: AppColors.activeColor,
                        height: 20.h,
                        width: 20.w,
                      )
                    ],
                  ),
                ),
              ),
              UIHelper.verticalSpace(10),

              // * Feedback
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.feedbackIcon,
                            color: AppColors.activeColor,
                            height: 20.h,
                            width: 20.w,
                          ),
                          UIHelper.horizontalSpace(15),
                          Text(
                            'ফিডব্যাক দিন',
                            style:
                                TextFontStyle.textLine12w500Kalpurush.copyWith(
                              color: Colors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      SvgPicture.asset(
                        AppIcons.arrowNextIcon,
                        color: AppColors.activeColor,
                        height: 20.h,
                        width: 20.w,
                      )
                    ],
                  ),
                ),
              ),
              UIHelper.verticalSpace(10),

              // * Feedback
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.locationIcon,
                            color: AppColors.activeColor,
                            height: 20.h,
                            width: 20.w,
                          ),
                          UIHelper.horizontalSpace(15),
                          Text(
                            'আমাদের সম্পর্কে',
                            style:
                                TextFontStyle.textLine12w500Kalpurush.copyWith(
                              color: Colors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      SvgPicture.asset(
                        AppIcons.arrowNextIcon,
                        color: AppColors.activeColor,
                        height: 20.h,
                        width: 20.w,
                      )
                    ],
                  ),
                ),
              ),
              UIHelper.verticalSpace(10),
            ],
          ),
        ),
      ),
    );
  }
}
