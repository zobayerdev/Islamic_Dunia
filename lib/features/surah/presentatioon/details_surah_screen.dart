// ignore_for_file: unused_local_variable, deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:islamic_dunia/assets_helper/app_fonts.dart';
import 'package:islamic_dunia/assets_helper/app_icons.dart';
import 'package:islamic_dunia/assets_helper/app_images.dart';
import 'package:islamic_dunia/assets_helper/app_lottie.dart';
import 'package:islamic_dunia/features/surah/model/surah_details_model.dart';
import 'package:islamic_dunia/networks/api_acess.dart';
import 'package:lottie/lottie.dart';

class SurahDetailsScreen extends StatefulWidget {
  final String sName;
  const SurahDetailsScreen({required this.sName, super.key});

  @override
  State<SurahDetailsScreen> createState() => _SurahDetailsScreenState();
}

class _SurahDetailsScreenState extends State<SurahDetailsScreen> {
  @override
  void initState() {
    super.initState();
    getSurahDetailsRX.surahDetailAPI(widget.sName);
  }

  @override
  Widget build(BuildContext context) {
    log("SurahDetailsScreen: ${widget.sName}");
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
              child: Column(
                children: [
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
                          StreamBuilder<SurahDetailModel>(
                            stream: getSurahDetailsRX.dataFetcher,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                SurahDetailModel surahDetailModel =
                                    snapshot.data!;
                                var surahName = surahDetailModel;
                                return Column(
                                  children: [
                                    SvgPicture.asset(
                                      AppIcons.quran,
                                      height: 50,
                                      width: 50,
                                      color: AppColors.white,
                                    ),
                                    Text(
                                      widget.sName,
                                      style: TextFontStyle
                                          .textStyle16w600Poppins
                                          .copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'مواقيت الصلاة لمدة 30 يومًا',
                                      style: TextFontStyle
                                          .textStyle16w600Poppins
                                          .copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                );
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: Lottie.asset(
                                    AppLottie.whiteLottie,
                                    height: 30,
                                    width: 30,
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Text(
                                    "দুঃখিত !! সূরার তালিকা পাওয়া যায়নি",
                                    style: TextFontStyle.textLine12w500Kalpurush
                                        .copyWith(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              }
                            },
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  StreamBuilder<SurahDetailModel>(
                    stream: getSurahDetailsRX.dataFetcher,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Lottie.asset(
                            AppLottie.whiteLottie,
                            height: 350,
                            width: 350,
                          ),
                        );
                      }

                      if (snapshot.hasData) {
                        SurahDetailModel? surahDetailModel = snapshot.data;

                        // Ensure we have a valid list of Surahs
                        List<Surah>? surahList = surahDetailModel?.surah;
                        if (surahList == null || surahList.isEmpty) {
                          return Center(
                            child: Text(
                              "দুঃখিত !! সূরার তালিকা পাওয়া যায়নি",
                              style: TextFontStyle.textLine12w500Kalpurush
                                  .copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: surahList.length,
                          itemBuilder: (context, index) {
                            Surah surah =
                                surahList[index]; // Get each Surah correctly

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      PrayerTimeWidget(
                                        arabicLine: surah.arabic ??
                                            "N/A", // Correct Surah name
                                        banglaLine: surah.bangla ??
                                            "N/A", // Correct Surah name
                                        ficon: AppIcons.surahIcon,
                                        licon: AppIcons.fajr,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Column(
                          children: [
                            Center(
                              child: Text(
                                "দুঃখিত !! সূরার তালিকা পাওয়া যায়নি",
                                style: TextFontStyle.textLine12w500Kalpurush
                                    .copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Lottie.asset(
                              AppLottie.whiteLottie,
                              height: 350,
                              width: 350,
                            ),
                          ],
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PrayerTimeWidget extends StatelessWidget {
  final String banglaLine;
  final String arabicLine;
  final String ficon;
  final String licon;

  const PrayerTimeWidget({
    required this.banglaLine,
    required this.arabicLine,
    required this.ficon,
    required this.licon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              // Allows text to take available space and wrap
              child: Text(
                arabicLine,
                style: TextFontStyle.textLine12w500Kalpurush.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                softWrap: true, // Ensures wrapping
                overflow: TextOverflow.visible,
                textAlign: TextAlign.end, // Ensures text is shown fully
              ),
            ),
            SizedBox(width: 5),
            SvgPicture.asset(
              ficon,
              height: 20,
            ),
            SizedBox(width: 5),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            SvgPicture.asset(
              ficon,
              height: 20,
            ),
            SizedBox(width: 5),
            Expanded(
              // Allows text to take available space and wrap
              child: Text(
                banglaLine,
                style: TextFontStyle.textLine12w500Kalpurush.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                softWrap: true, // Ensures wrapping
                overflow: TextOverflow.visible, // Ensures text is shown fully
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
      ],
    );
  }
}
