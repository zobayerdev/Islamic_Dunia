import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:islamic_dunia/assets_helper/app_fonts.dart';
import 'package:islamic_dunia/assets_helper/app_icons.dart';
import 'package:islamic_dunia/assets_helper/app_lottie.dart';
import 'package:islamic_dunia/features/home/model/prayer_time_model.dart';
import 'package:islamic_dunia/features/home/model/ramjan_time_model.dart';
import 'package:islamic_dunia/helpers/navigation_service.dart';
import 'package:islamic_dunia/networks/api_acess.dart';
import 'package:lottie/lottie.dart';

import '../../../helpers/all_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentTime = '';
  late Timer _timer;

  void getCurrentTime() {
    final now = DateTime.now();
    final formatter = DateFormat('hh:mm:ss a');
    setState(() {
      currentTime = formatter.format(now);
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentTime();
    getPrayerTimeRX.prayerTimeAPI();
    getRamjanTimeRX.ramjanTimeAPI();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      getCurrentTime();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.9),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StreamBuilder<RamjanTimeModel>(
                    stream: getRamjanTimeRX
                        .dataFetcher, // Assuming this is your stream
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Lottie.asset(
                          AppLottie.whiteLottie,
                          height: 100,
                          width: 100,
                        );
                      }
                      if (snapshot.hasData) {
                        RamjanTimeModel ramjanTimeModel = snapshot.data!;
                        var time = ramjanTimeModel.data!;

                        // Get today's date in "dd MMM yyyy" format (e.g., 02 Mar 2025)
                        String todayDate =
                            DateFormat('dd MMM yyyy').format(DateTime.now());

                        // Filter data to get only today's date
                        var todayData = time
                            .where((datum) => datum.date == todayDate)
                            .toList();

                        if (todayData.isEmpty) {
                          return Center(
                            child: Text(
                              'No data available for today.',
                              style:
                                  TextFontStyle.textStyle13w500Poppins.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          );
                        }

                        // Display today's data
                        return Column(
                          children: [
                            Text(
                              todayData[0].ramjanNo!.toString() +
                                  " Ramadan" +
                                  ", " +
                                  "2025",
                              style:
                                  TextFontStyle.textStyle13w500Poppins.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.whiteColor,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              todayData[0].dayName! + ", " + todayData[0].date!,
                              style: TextFontStyle.smallStyle10w500Poppins
                                  .copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Lottie.asset(
                          AppLottie.whiteLottie,
                          height: 80,
                          width: 80,
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 230,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "Assalamualaikum, User",
                            style:
                                TextFontStyle.textStyle13w500Poppins.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteColor,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'السلام عليكم ورحمة الله وبركاتة',
                            style:
                                TextFontStyle.textStyle13w500Poppins.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteColor,
                            ),
                          ),
                          Text(
                            "Then which of the favours of your Lord will ye deny?",
                            style:
                                TextFontStyle.smallStyle11w400Poppins.copyWith(
                              color: AppColors.whiteColor,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            currentTime,
                            style: TextFontStyle.headLine24w600Poppins.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteColor,
                            ),
                          ),
                          SizedBox(height: 10),
                          StreamBuilder<PrayerTimeModel>(
                            stream: getPrayerTimeRX
                                .dataFetcher, // Assuming you have a stream
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Lottie.asset(
                                  AppLottie.whiteLottie,
                                  height: 80,
                                  width: 80,
                                );
                              }

                              if (snapshot.hasData) {
                                PrayerTimeModel prayerTimeModel =
                                    snapshot.data!;
                                var time = prayerTimeModel.items!;

                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    PrayerTimeWidget(
                                      prayerName: "Fajr",
                                      time: time[0].fajr ?? 'No time available',
                                      icon: AppIcons.fajr,
                                    ),
                                    PrayerTimeWidget(
                                      prayerName: "Dhuhr",
                                      time:
                                          time[0].dhuhr ?? 'No time available',
                                      icon: AppIcons.duhr,
                                    ),
                                    PrayerTimeWidget(
                                      prayerName: "Asr",
                                      time: time[0].asr ?? 'No time available',
                                      icon: AppIcons.asr,
                                    ),
                                    PrayerTimeWidget(
                                      prayerName: "Maghrib",
                                      time: time[0].maghrib ??
                                          'No time available',
                                      icon: AppIcons.magrib,
                                    ),
                                    PrayerTimeWidget(
                                      prayerName: "Isha",
                                      time: time[0].isha ?? 'No time available',
                                      icon: AppIcons.isha,
                                    ),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return Lottie.asset(
                                  AppLottie.whiteLottie,
                                  height: 80,
                                  width: 80,
                                );
                              } else {
                                return Lottie.asset(
                                  AppLottie.whiteLottie,
                                  height: 80,
                                  width: 80,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
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
                                  AppIcons.quran,
                                  height: 30,
                                  width: 30,
                                  color: AppColors.primaryColor,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "The Quran",
                                  style: TextFontStyle.textStyle14w600Poppins
                                      .copyWith(
                                    color: AppColors.primaryColor,
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
                              children: [
                                SvgPicture.asset(
                                  AppIcons.book,
                                  height: 22,
                                  width: 22,
                                  color: AppColors.primaryColor,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Story Time",
                                  style: TextFontStyle.textStyle14w600Poppins
                                      .copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
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
                                  AppIcons.tasbih,
                                  height: 30,
                                  width: 30,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Tasbih Counter",
                                  style: TextFontStyle.textStyle14w600Poppins
                                      .copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            NavigationService.navigateTo(
                              Routes.prayerTimeScreen,
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
                                    AppIcons.clock,
                                    height: 22,
                                    width: 22,
                                    color: AppColors.primaryColor,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Prayer Time",
                                    style: TextFontStyle.textStyle14w600Poppins
                                        .copyWith(
                                      color: AppColors.primaryColor,
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
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Today\'s Hadith',
                            style: TextFontStyle.headLine22w600Poppins.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Text(
                            'রাসূলুল্লাহ (সঃ) বলেছেন:"যে ব্যক্তি মানুষের উপকারের জন্য কিছু ভালো কাজ করবে, সে আল্লাহর কাছে সবচেয়ে ভালো মানুষ হবে।"',
                            style:
                                TextFontStyle.textLine12w500Kalpurush.copyWith(
                              color: AppColors.primaryColor,
                              fontFamily: "Kalpurush",
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'قال رسول الله صلى الله عليه وسلم:" من لا يَفعَل الخير للناس فهو من أسوأ الناس عند الله."',
                            style:
                                TextFontStyle.textStyle12w500Poppins.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'The Messenger of Allah (peace be upon him) said: "Whoever does good for others is the best of people in the sight of Allah."',
                            style:
                                TextFontStyle.textStyle12w500Poppins.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
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
              style: TextFontStyle.smallStyle11w400Poppins.copyWith(
                color: AppColors.whiteColor,
              ),
            ),
            SizedBox(height: 5),
            SvgPicture.asset(
              icon,
              height: 20,
              width: 20,
              color: AppColors.whiteColor,
            ),
            SizedBox(height: 5),
            Text(
              time,
              style: TextFontStyle.smallStyle11w400Poppins.copyWith(
                color: AppColors.whiteColor,
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
