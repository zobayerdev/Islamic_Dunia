// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:islamic_dunia/assets_helper/app_fonts.dart';
import 'package:islamic_dunia/assets_helper/app_icons.dart';
import 'package:islamic_dunia/assets_helper/app_images.dart';
import 'package:islamic_dunia/assets_helper/app_lottie.dart';
import 'package:islamic_dunia/common_widgets/custom_appbar.dart';
import 'package:islamic_dunia/features/hadis/widget/hadis_model.dart';
import 'package:islamic_dunia/networks/api_acess.dart';
import 'package:lottie/lottie.dart';

class HadisScreen extends StatefulWidget {
  const HadisScreen({super.key});

  @override
  State<HadisScreen> createState() => _HadisScreenState();
}

class _HadisScreenState extends State<HadisScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHadisRX.hadisAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'হাদিস সমূহ',
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
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
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
                  SizedBox(height: 20),
                  StreamBuilder<HadisModel>(
                    stream: getHadisRX.dataFetcher,
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
                        HadisModel? hadisModel = snapshot.data;

                        // Ensure we have a valid list of Surahs
                        List<Datum>? hadisList = hadisModel?.data;
                        if (hadisList == null || hadisList.isEmpty) {
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
                          itemCount: hadisList.length,
                          itemBuilder: (context, index) {
                            Datum surah =
                                hadisList[index]; // Get each Surah correctly

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
                                        titleLine: surah.title ?? "N/A",
                                        banglaAnubadLine:
                                            surah.banglaAnubad ?? "N/A",
                                        arabicLine: surah.arabic ??
                                            "N/A", // Correct Surah name
                                        banglaLine: surah.bangla ?? "N/A",
                                        englishLine: surah.english ??
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
                  ),
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
  final String titleLine;
  final String banglaLine;
  final String banglaAnubadLine;
  final String arabicLine;
  final String englishLine;
  final String ficon;
  final String licon;

  const PrayerTimeWidget({
    required this.titleLine,
    required this.banglaLine,
    required this.banglaAnubadLine,
    required this.arabicLine,
    required this.englishLine,
    required this.ficon,
    required this.licon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                titleLine,
                style: TextFontStyle.textLine12w500Kalpurush.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                softWrap: true, // Ensures wrapping
                overflow: TextOverflow.visible, // Ensures text is shown fully
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
        SizedBox(height: 10),
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
                englishLine,
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
