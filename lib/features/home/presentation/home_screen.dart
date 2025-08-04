// ignore_for_file: deprecated_member_use
import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:islamic_dunia/assets_helper/app_fonts.dart';
import 'package:islamic_dunia/assets_helper/app_icons.dart';
import 'package:islamic_dunia/assets_helper/app_lottie.dart';
import 'package:islamic_dunia/constants/app_constants.dart';
import 'package:islamic_dunia/features/home/presentation/fasting_time/model/fasting_model.dart';
import 'package:islamic_dunia/features/home/presentation/prayertime/model/home_prayertime_model.dart';
import 'package:islamic_dunia/helpers/di.dart';
import 'package:islamic_dunia/helpers/navigation_service.dart';
import 'package:islamic_dunia/networks/api_acess.dart';
import 'package:islamic_dunia/prayer_timer_screen.dart';
import 'package:lottie/lottie.dart';
import '../../../helpers/all_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // * read data from appData
  late final dynamic latitude,
      longitude,
      timeZone,
      timeZoneArea,
      school,
      address,
      calculation;
  // * others variables
  String currentTime = '';
  late Timer _timer;
  String selectedAddressEnglish = '';
  String selectedAddressBengali = '';
  void getCurrentTime() {
    final now = DateTime.now();
    final formatter = DateFormat('hh:mm:ss a');
    setState(() {
      currentTime = formatter.format(now);
    });
  }

  String getCurrentDate() {
    final now = DateTime.now();
    final formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(now);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    log('Current date: ${getCurrentDate()}');
  }

  @override
  void initState() {
    super.initState();
    getCurrentTime();

    latitude = appData.read(kKeyLatitude);
    longitude = appData.read(kKeyLongitude);
    timeZone = appData.read(kKeyTimeZone);
    timeZoneArea = appData.read(kKeyTimeZoneArea);
    school = appData.read(kKeySchool);
    calculation = appData.read(kKeyCalculation);
    address = appData.read(kKeySelectedAddress);

    log('Latitude: $latitude, Longitude: $longitude');
    log('Time Zone: $timeZone, Time Zone Area: $timeZoneArea');
    log('School: $school, Calculation: $calculation');
    log('Address: $address');

    getPrayerTimeRX.prayerTimeAPI(
        lat: latitude, lng: longitude, method: calculation, school: school);

    getFastingRX.dailyFastingAPI(lat: latitude, lon: longitude);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      getCurrentTime();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String convertTo12HourFormat(String time24) {
    try {
      // Split the time string into hours and minutes
      final parts = time24.split(':');
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);

      // Determine AM/PM and convert hour
      String period = hour >= 12 ? 'PM' : 'AM';
      if (hour == 0) {
        hour = 12; // Midnight case
      } else if (hour > 12) {
        hour = hour - 12; // Convert to 12-hour format
      }

      // Format the time with leading zeros
      return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
    } catch (e) {
      // Return original time if parsing fails
      return time24;
    }
  }

  @override
  Widget build(BuildContext context) {
    appData.read(kKeySelectedAddress);
    appData.read(kKeyTimeZone);
    appData.read(kKeyTimeZoneArea);
    appData.read(kKeyLatitude);
    appData.read(kKeyLongitude);
    appData.read(kKeySchool);
    appData.read(kKeyCalculation);

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.cDCE4E6.withOpacity(0.9),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // * get prayer time
                  Container(
                    height: 260,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "আসসালামুয়ালাইকুম ওয়া রাহমাতুল্লাহি ওয়া বারাকাতুহু",
                            style: TextFontStyle.textLine12w500Kalpurush
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                    fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'السلام عليكم ورحمة الله وبركاتة',
                            style:
                                TextFontStyle.textStyle13w500Poppins.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Text(
                            "Then which of the favours of your Lord will ye deny?",
                            style:
                                TextFontStyle.smallStyle11w400Poppins.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            currentTime,
                            style: TextFontStyle.headLine24w600Poppins.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          SizedBox(height: 10),
                          StreamBuilder<FastingModel>(
                            stream: getFastingRX.horseissue,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                FastingModel fastingModel = snapshot.data!;
                                var time = fastingModel.data?.fasting;

                                String sahurTime =
                                    time?[0].time?.sahur ?? '00:00';
                                String iftarTime =
                                    time?[0].time?.iftar ?? '00:00';

                                // Convert times to 12-hour format
                                String formattedSahurTime =
                                    convertTo12HourFormat(sahurTime);
                                String formattedIftarTime =
                                    convertTo12HourFormat(iftarTime);

                                log('Fasting times: ${time?[0].time?.sahur}, ${time?[0].time?.iftar}');
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'সেহেরি: ',
                                            style: TextFontStyle
                                                .textLine12w500Kalpurush
                                                .copyWith(
                                              color: AppColors.primaryColor,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            formattedSahurTime,
                                            style: TextFontStyle
                                                .textLine12w500Kalpurush
                                                .copyWith(
                                              color: AppColors.primaryColor,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'ইফতার: ',
                                            style: TextFontStyle
                                                .textLine12w500Kalpurush
                                                .copyWith(
                                              color: AppColors.primaryColor,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            formattedIftarTime,
                                            style: TextFontStyle
                                                .textLine12w500Kalpurush
                                                .copyWith(
                                              color: AppColors.primaryColor,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return SizedBox.shrink();
                            },
                          ),
                          SizedBox(height: 10),
                          StreamBuilder<HomePrayerTimeModel>(
                            stream: getPrayerTimeRX.dataFetcher,
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
                                HomePrayerTimeModel prayerTimeModel =
                                    snapshot.data!;
                                var time = prayerTimeModel.data?.times;

                                log('Prayer times: ${time?.fajr}, ${time?.dhuhr}, ${time?.asr}, ${time?.maghrib}, ${time?.isha}');

                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        PrayerTimeWidget(
                                          prayerName: "ফজর",
                                          time: time?.fajr ?? '00:00',
                                          icon: AppIcons.fajr,
                                        ),
                                        PrayerTimeWidget(
                                          prayerName: "যোহর",
                                          time: time?.dhuhr ?? '00:00',
                                          icon: AppIcons.duhr,
                                        ),
                                        PrayerTimeWidget(
                                          prayerName: "আসর",
                                          time: time?.asr ?? '00:00',
                                          icon: AppIcons.asr,
                                        ),
                                        PrayerTimeWidget(
                                          prayerName: "মাগরিব",
                                          time: time?.maghrib ?? '00:00',
                                          icon: AppIcons.magrib,
                                        ),
                                        PrayerTimeWidget(
                                          prayerName: "এশা",
                                          time: time?.isha ?? '00:00',
                                          icon: AppIcons.isha,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
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

                  StreamBuilder<HomePrayerTimeModel>(
                      stream: getPrayerTimeRX.dataFetcher,
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
                          HomePrayerTimeModel prayerTimeModel = snapshot.data!;
                          var time = prayerTimeModel.data?.times;

                          log('Circular Prayer times: ${time?.fajr}, ${time?.dhuhr}, ${time?.asr}, ${time?.maghrib}, ${time?.isha}');

                          return PrayerTimer(
                            prayerTimesInput: {
                              'Fajr': time?.fajr ?? '05:00',
                              'Dhuhr': time?.dhuhr ?? '12:05',
                              'Asr': time?.asr ?? '15:30',
                              'Maghrib': time?.maghrib ?? '18:41',
                              'Isha': time?.isha ?? '20:03',
                            },
                            progressBarSize: 130.0,
                            progressBarColor: AppColors.primaryColor,
                            progressBarBackgroundColor: Colors.grey,
                            fontColor: Colors.black,
                            containerHeight: '210',
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
                      }),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            NavigationService.navigateTo(
                              Routes.quranPDFScreen,
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
                                    AppIcons.quran,
                                    height: 30,
                                    width: 30,
                                    color: AppColors.primaryColor,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "আল কোরআন",
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
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            NavigationService.navigateTo(
                              Routes.islamicStoryScreen,
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
                                    AppIcons.book,
                                    height: 22,
                                    width: 22,
                                    color: AppColors.primaryColor,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "ইসলামিক গল্প",
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
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            NavigationService.navigateTo(
                              Routes.tasbihScreen,
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
                                    AppIcons.tasbih,
                                    height: 30,
                                    width: 30,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "তাসবিহ গননা",
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
                                    "নামাযের সময়সূচী",
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

  String _formatTime(String time) {
    try {
      // Assuming the input time is in "HH:mm" format (e.g., "07:45" or "19:45")
      final DateTime parsedTime = DateFormat('HH:mm').parse(time);
      // Format to "h:mm a" for AM/PM (e.g., "7:45 AM" or "7:45 PM")
      return DateFormat('h:mm a').format(parsedTime);
    } catch (e) {
      // Return original time if parsing fails
      return time;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              prayerName,
              style: TextFontStyle.textLine12w500Kalpurush.copyWith(
                color: AppColors.primaryColor,
                fontSize: 16,
              ),
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
              _formatTime(time), // Use formatted time
              style: TextFontStyle.smallStyle11w400Poppins.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
