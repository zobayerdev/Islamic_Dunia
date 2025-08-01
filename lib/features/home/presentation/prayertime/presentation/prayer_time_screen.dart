// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:islamic_dunia/assets_helper/app_fonts.dart';
import 'package:islamic_dunia/assets_helper/app_icons.dart';
import 'package:islamic_dunia/assets_helper/app_images.dart';
import 'package:islamic_dunia/assets_helper/app_lottie.dart';
import 'package:islamic_dunia/common_widgets/custom_appbar.dart';
import 'package:islamic_dunia/features/home/presentation/prayertime/model/monthly_pray_model.dart';
import 'package:islamic_dunia/networks/api_acess.dart';
import 'package:lottie/lottie.dart';

class PrayerTimeScreen extends StatefulWidget {
  const PrayerTimeScreen({super.key});

  @override
  State<PrayerTimeScreen> createState() => _PrayerTimeScreenState();
}

class _PrayerTimeScreenState extends State<PrayerTimeScreen> {
  @override
  void initState() {
    super.initState();
    getMonthlyPrayerTimeRX.monthPrayerTimeAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "মাসিক নামাযের সময়",
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                "৩০ দিনের নামাযের সময়",
                                style: TextFontStyle.textLine12w500Kalpurush
                                    .copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                              ),
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
                  StreamBuilder<MonthlyPrayTimeModel>(
                    stream: getMonthlyPrayerTimeRX.dataFetcher,
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
                        MonthlyPrayTimeModel monthlyPrayTimeModel =
                            snapshot.data!;
                        var prayerTime = monthlyPrayTimeModel.items;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: prayerTime!.length,
                          itemBuilder: (context, index) {
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Date: ",
                                            style: TextFontStyle
                                                .textStyle16w600Poppins
                                                .copyWith(
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            prayerTime[index].dateFor!,
                                            style: TextFontStyle
                                                .textStyle16w600Poppins
                                                .copyWith(
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          PrayerTimeWidget(
                                            prayerName: "ফজর",
                                            time: prayerTime[index].fajr! ??
                                                'N/A',
                                            icon: AppIcons.fajr,
                                          ),
                                          PrayerTimeWidget(
                                            prayerName: "যোহর",
                                            time: prayerTime[index].dhuhr! ??
                                                "N/A",
                                            icon: AppIcons.duhr,
                                          ),
                                          PrayerTimeWidget(
                                            prayerName: "আছর",
                                            time:
                                                prayerTime[index].asr! ?? "N/A",
                                            icon: AppIcons.asr,
                                          ),
                                          PrayerTimeWidget(
                                            prayerName: "মাগরিব",
                                            time: prayerTime[index].maghrib! ??
                                                "N/A",
                                            icon: AppIcons.magrib,
                                          ),
                                          PrayerTimeWidget(
                                            prayerName: "এশা",
                                            time: prayerTime[index].isha! ??
                                                "N/A",
                                            icon: AppIcons.isha,
                                          ),
                                        ],
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
                                "দুঃখিত !! নামাযের সময় পাওয়া যায়নি",
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
  final String prayerName;
  final String time;
  final String icon;

  const PrayerTimeWidget({
    required this.prayerName,
    required this.time,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              prayerName,
              style: TextFontStyle.textLine12w500Kalpurush
                  .copyWith(color: AppColors.primaryColor, fontSize: 15),
            ),
            SizedBox(height: 5),
            SvgPicture.asset(
              icon,
              height: 20,
              width: 20,
              color: AppColors.primaryColor,
            ),
            SizedBox(height: 5),
            Text(
              time,
              style: TextFontStyle.smallStyle11w400Poppins.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
