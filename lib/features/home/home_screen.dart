import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:islamic_dunia/assets_helper/app_fonts.dart';
import 'package:islamic_dunia/assets_helper/app_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                  Text(
                    "9 Ramadan 1442",
                    style: TextFontStyle.textStyle13w500Poppins.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    "Tuesday, 20 April 2024",
                    style: TextFontStyle.smallStyle9w500Poppins.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 250,
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
                            "04:00 AM",
                            style: TextFontStyle.headLine24w600Poppins.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteColor,
                            ),
                          ),
                          Text(
                            "Fajr 3 hours 9 mins left",
                            style:
                                TextFontStyle.smallStyle11w400Poppins.copyWith(
                              color: AppColors.whiteColor,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              PrayerTimeWidget(
                                prayerName: "Fajr",
                                time: "05:00 AM",
                                icon: AppIcons.fajr,
                              ),
                              PrayerTimeWidget(
                                prayerName: "Dhuhr",
                                time: "12:00 PM",
                                icon: AppIcons
                                    .duhr, // Assuming you have an icon for Dhuhr
                              ),
                              PrayerTimeWidget(
                                prayerName: "Asr",
                                time: "03:30 PM",
                                icon: AppIcons
                                    .asr, // Assuming you have an icon for Asr
                              ),
                              PrayerTimeWidget(
                                prayerName: "Maghrib",
                                time: "06:00 PM",
                                icon: AppIcons
                                    .magrib, // Assuming you have an icon for Maghrib
                              ),
                              PrayerTimeWidget(
                                prayerName: "Isha",
                                time: "08:00 PM",
                                icon: AppIcons
                                    .isha, // Assuming you have an icon for Isha
                              ),
                            ],
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
              ),
            ),
          ],
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
