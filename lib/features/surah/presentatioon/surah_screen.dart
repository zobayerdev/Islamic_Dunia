// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:islamic_dunia/assets_helper/app_fonts.dart';
import 'package:islamic_dunia/assets_helper/app_icons.dart';
import 'package:islamic_dunia/assets_helper/app_images.dart';
import 'package:islamic_dunia/assets_helper/app_lottie.dart';
import 'package:islamic_dunia/common_widgets/custom_appbar.dart';
import 'package:islamic_dunia/features/surah/model/surah_model.dart';
import 'package:islamic_dunia/helpers/all_routes.dart';
import 'package:islamic_dunia/helpers/navigation_service.dart';
import 'package:islamic_dunia/networks/api_acess.dart';
import 'package:lottie/lottie.dart';

class SsurahScreen extends StatefulWidget {
  const SsurahScreen({super.key});

  @override
  State<SsurahScreen> createState() => _SsurahScreenState();
}

class _SsurahScreenState extends State<SsurahScreen> {
  @override
  void initState() {
    super.initState();
    getSurahRX.surahAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "সকল সুরা সমূহ",
        ),
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
                            Column(
                              children: [
                                SvgPicture.asset(
                                  AppIcons.quran,
                                  height: 50,
                                  width: 50,
                                  color: AppColors.white,
                                ),
                                Text(
                                  "114 Surah List",
                                  style: TextFontStyle.textStyle16w600Poppins
                                      .copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'مواقيت الصلاة لمدة 30 يومًا',
                                  style: TextFontStyle.textStyle16w600Poppins
                                      .copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // ListView.builder directly without SizedBox or Expanded
                    StreamBuilder<SurahModel>(
                      stream: getSurahRX.dataFetcher,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Lottie.asset(
                              AppLottie.whiteLottie,
                              height: 350,
                              width: 350,
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          SurahModel surahModel = snapshot.data!;
                          var surahName = surahModel.surahList;
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: surahName!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    log("===============> ${surahName[index].name}");
                                    log("===============> ${surahName[index].bangla}");
                                    var sName = surahName[index].name;
                                    var sBangla = surahName[index].bangla;
                                    await getSurahDetailsRX
                                        .surahDetailAPI(surahName[index].name);
                                    NavigationService.navigateToWithArgs(
                                      Routes.surahDetailsScreen,
                                      {"sName": sName, "sBangla": sBangla},
                                    );
                                  },
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "সূরা নম্বর: ",
                                                style: TextFontStyle
                                                    .textLine12w500Kalpurush
                                                    .copyWith(
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Text(
                                                surahName[index]
                                                    .number!
                                                    .toString(),
                                                style: TextFontStyle
                                                    .textLine12w500Kalpurush
                                                    .copyWith(
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          PrayerTimeWidget(
                                            prayerName:
                                                surahName[index].bangla!,
                                            ficon: AppIcons.surahIcon,
                                            licon: AppIcons.fajr,
                                          ),
                                        ],
                                      ),
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class PrayerTimeWidget extends StatelessWidget {
  final String prayerName;
  final String ficon;
  final String licon;

  const PrayerTimeWidget({
    required this.prayerName,
    required this.ficon,
    required this.licon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              ficon,
              height: 20,
            ),
            SizedBox(width: 5),
            Text(
              prayerName,
              style: TextFontStyle.textLine12w500Kalpurush.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
