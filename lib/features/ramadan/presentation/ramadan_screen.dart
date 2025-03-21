// ignore_for_file: deprecated_member_use

// ###########################################################################################################
// ###########################################################################################################
// ################################################# Start English code ######################################
// ###########################################################################################################
// ###########################################################################################################
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:islamic_dunia/assets_helper/app_fonts.dart';
import 'package:islamic_dunia/assets_helper/app_icons.dart';
import 'package:islamic_dunia/assets_helper/app_images.dart';
import 'package:islamic_dunia/assets_helper/app_lottie.dart';
import 'package:islamic_dunia/common_widgets/custom_appbar.dart';
import 'package:islamic_dunia/features/home/model/ramjan_time_model.dart';
import 'package:islamic_dunia/networks/api_acess.dart';
import 'package:lottie/lottie.dart';

class RamadanScreen extends StatefulWidget {
  const RamadanScreen({super.key});

  @override
  State<RamadanScreen> createState() => _RamadanScreenState();
}

class _RamadanScreenState extends State<RamadanScreen> {
  @override
  void initState() {
    super.initState();
    getRamjanTimeRX.ramjanTimeAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Ramadan Calendar',
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.cDCE4E6.withOpacity(0.9),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
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
                        image: AssetImage(AppImages.ramadan),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          AppColors.primaryColor.withOpacity(0.9),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                    child: StreamBuilder<RamjanTimeModel>(
                      stream: getRamjanTimeRX.dataFetcher,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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

                          // Filter data to get today's date and future dates
                          var filteredData = time
                              .where((datum) =>
                                  DateFormat('dd MMM yyyy')
                                      .parse(datum.date!)
                                      .isAfter(DateTime.now()
                                          .subtract(Duration(days: 1))) ||
                                  datum.date == todayDate)
                              .toList();

                          if (filteredData.isEmpty) {
                            return Center(
                              child: Text(
                                'No data available for today or future dates.',
                                style: TextFontStyle.textStyle13w500Poppins
                                    .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            );
                          }

                          // Display today's data and future dates
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  filteredData[0].ramjanNo!.toString() +
                                      " Ramadan, 2025",
                                  style: TextFontStyle.textLine12w500Kalpurush
                                      .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.whiteColor,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  filteredData[0].date!,
                                  style: TextFontStyle.textLine12w500Kalpurush
                                      .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.whiteColor,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Iftar Time: " +
                                          filteredData[0].iftarTime!,
                                      style: TextFontStyle
                                          .textLine12w500Kalpurush
                                          .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.whiteColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "&",
                                      style: TextFontStyle
                                          .textLine12w500Kalpurush
                                          .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.whiteColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Seheri End Time: " +
                                          filteredData[0].seheriFinish!,
                                      style: TextFontStyle
                                          .textLine12w500Kalpurush
                                          .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.whiteColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                  ),
                  SizedBox(height: 20),
                  StreamBuilder<RamjanTimeModel>(
                    stream: getRamjanTimeRX.dataFetcher,
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
                        RamjanTimeModel monthlyPrayTimeModel = snapshot.data!;
                        var prayerTime = monthlyPrayTimeModel.data;

                        // Filter only today's data and future data
                        var todayAndFuturePrayerTime = prayerTime!
                            .where((datum) =>
                                DateFormat('dd MMM yyyy')
                                    .parse(datum.date!)
                                    .isAfter(DateTime.now()
                                        .subtract(Duration(days: 1))) ||
                                datum.date ==
                                    DateFormat('dd MMM yyyy')
                                        .format(DateTime.now()))
                            .toList();

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: todayAndFuturePrayerTime.length,
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Date: ",
                                                style: TextFontStyle
                                                    .textLine12w500Kalpurush
                                                    .copyWith(
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                todayAndFuturePrayerTime[index]
                                                    .date!,
                                                style: TextFontStyle
                                                    .textLine12w500Kalpurush
                                                    .copyWith(
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Ramadan No: ",
                                                style: TextFontStyle
                                                    .textLine12w500Kalpurush
                                                    .copyWith(
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                todayAndFuturePrayerTime[index]
                                                    .ramjanNo!
                                                    .toString(),
                                                style: TextFontStyle
                                                    .textLine12w500Kalpurush
                                                    .copyWith(
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          PrayerTimeWidget(
                                            icon: AppIcons.fajr,
                                            seheriLastTime:
                                                todayAndFuturePrayerTime[index]
                                                    .seheriFinish!,
                                            iftarTime:
                                                todayAndFuturePrayerTime[index]
                                                    .iftarTime!,
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
                                "Sorry! Prayer times not available",
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
  final String seheriLastTime;
  final String iftarTime;
  final String icon;

  const PrayerTimeWidget({
    required this.icon,
    required this.seheriLastTime,
    required this.iftarTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              icon,
              height: 20,
              width: 20,
              color: AppColors.primaryColor,
            ),
            SizedBox(width: 20),
            Text(
              'Seheri End Time: ' + seheriLastTime,
              style: TextFontStyle.textLine12w500Kalpurush.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            SvgPicture.asset(
              icon,
              height: 20,
              width: 20,
              color: AppColors.primaryColor,
            ),
            SizedBox(width: 20),
            Text(
              'Iftar Time: ' + iftarTime,
              style: TextFontStyle.textLine12w500Kalpurush.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}


// ###########################################################################################################
// ###########################################################################################################
// ################################################# End English code ########################################
// ###########################################################################################################
// ###########################################################################################################
// // ignore_for_file: deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:intl/intl.dart';
// import 'package:islamic_dunia/assets_helper/app_colors.dart';
// import 'package:islamic_dunia/assets_helper/app_fonts.dart';
// import 'package:islamic_dunia/assets_helper/app_icons.dart';
// import 'package:islamic_dunia/assets_helper/app_images.dart';
// import 'package:islamic_dunia/assets_helper/app_lottie.dart';
// import 'package:islamic_dunia/common_widgets/custom_appbar.dart';
// import 'package:islamic_dunia/features/home/model/ramjan_time_model.dart';
// import 'package:islamic_dunia/networks/api_acess.dart';
// import 'package:lottie/lottie.dart';

// class RamadanScreen extends StatefulWidget {
//   const RamadanScreen({super.key});

//   @override
//   State<RamadanScreen> createState() => _RamadanScreenState();
// }

// class _RamadanScreenState extends State<RamadanScreen> {
//   @override
//   void initState() {
//     super.initState();
//     getRamjanTimeRX.ramjanTimeAPI();
//   }

//   String convertToBanglaNumerals(String input) {
//     Map<String, String> numeralsMap = {
//       '0': '০',
//       '1': '১',
//       '2': '২',
//       '3': '৩',
//       '4': '৪',
//       '5': '৫',
//       '6': '৬',
//       '7': '৭',
//       '8': '৮',
//       '9': '৯',
//     };

//     return input.split('').map((char) {
//       return numeralsMap[char] ?? char;
//     }).join('');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'রমাদান ক্যালেন্ডার',
//       ),
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: AppColors.cDCE4E6.withOpacity(0.9),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   Container(
//                     height: 200,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16),
//                       image: DecorationImage(
//                         image: AssetImage(AppImages.ramadan),
//                         fit: BoxFit.cover,
//                         colorFilter: ColorFilter.mode(
//                           AppColors.primaryColor.withOpacity(0.9),
//                           BlendMode.darken,
//                         ),
//                       ),
//                     ),
//                     child: StreamBuilder<RamjanTimeModel>(
//                       stream: getRamjanTimeRX
//                           .dataFetcher, // Assuming this is your stream
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return Lottie.asset(
//                             AppLottie.whiteLottie,
//                             height: 100,
//                             width: 100,
//                           );
//                         }
//                         if (snapshot.hasData) {
//                           RamjanTimeModel ramjanTimeModel = snapshot.data!;
//                           var time = ramjanTimeModel.data!;

//                           // Get today's date in "dd MMM yyyy" format (e.g., 02 Mar 2025)
//                           String todayDate =
//                               DateFormat('dd MMM yyyy').format(DateTime.now());

//                           // Filter data to get only today's date
//                           var todayData = time
//                               .where((datum) => datum.date == todayDate)
//                               .toList();

//                           if (todayData.isEmpty) {
//                             return Center(
//                               child: Text(
//                                 'আজকের জন্য কোনও ডেটা পাওয়া যায়নি।', // "No data available for today."
//                                 style: TextFontStyle.textStyle13w500Poppins
//                                     .copyWith(
//                                   fontWeight: FontWeight.bold,
//                                   color: AppColors.whiteColor,
//                                 ),
//                               ),
//                             );
//                           }

//                           // Mapping for English to Bangla weekdays
//                           Map<String, String> banglaWeekdays = {
//                             'Monday': 'সোমবার',
//                             'Tuesday': 'মঙ্গলবার',
//                             'Wednesday': 'বুধবার',
//                             'Thursday': 'বৃহস্পতিবার',
//                             'Friday': 'শুক্রবার',
//                             'Saturday': 'শনিবার',
//                             'Sunday': 'রবিবার',
//                           };

//                           // Get Bangla day name
//                           String banglaDayName =
//                               banglaWeekdays[todayData[0].dayName!] ??
//                                   todayData[0].dayName!;

//                           // Display today's data in Bangla
//                           return Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   todayData[0].ramjanNo!.toString() +
//                                       " রমজান" +
//                                       ", " +
//                                       "২০২৫", // 2025 in Bengali numerals
//                                   style: TextFontStyle.textLine12w500Kalpurush
//                                       .copyWith(
//                                     fontWeight: FontWeight.bold,
//                                     color: AppColors.whiteColor,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                                 SizedBox(height: 3),
//                                 Text(
//                                   "$banglaDayName, " +
//                                       convertToBanglaNumerals(
//                                           todayData[0].date!),
//                                   style: TextFontStyle.textLine12w500Kalpurush
//                                       .copyWith(
//                                     fontWeight: FontWeight.bold,
//                                     color: AppColors.whiteColor,
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                                 SizedBox(height: 10),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       "ইফতারের সময়: " + todayData[0].iftarTime!,
//                                       style: TextFontStyle
//                                           .textLine12w500Kalpurush
//                                           .copyWith(
//                                         fontWeight: FontWeight.bold,
//                                         color: AppColors.whiteColor,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                     SizedBox(width: 10),
//                                     Text(
//                                       "&",
//                                       style: TextFontStyle
//                                           .textLine12w500Kalpurush
//                                           .copyWith(
//                                         fontWeight: FontWeight.bold,
//                                         color: AppColors.whiteColor,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                     SizedBox(width: 10),
//                                     Text(
//                                       "সেহেরীর শেষ সময়: " +
//                                           todayData[0].seheriFinish!,
//                                       style: TextFontStyle
//                                           .textLine12w500Kalpurush
//                                           .copyWith(
//                                         fontWeight: FontWeight.bold,
//                                         color: AppColors.whiteColor,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           );
//                         } else {
//                           return Lottie.asset(
//                             AppLottie.whiteLottie,
//                             height: 80,
//                             width: 80,
//                           );
//                         }
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   // ListView.builder directly without SizedBox or Expanded
//                   StreamBuilder<RamjanTimeModel>(
//                     stream: getRamjanTimeRX.dataFetcher,
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(
//                           child: Lottie.asset(
//                             AppLottie.whiteLottie,
//                             height: 350,
//                             width: 350,
//                           ),
//                         );
//                       }
//                       if (snapshot.hasData) {
//                         RamjanTimeModel monthlyPrayTimeModel = snapshot.data!;
//                         var prayerTime = monthlyPrayTimeModel.data;
//                         return ListView.builder(
//                           shrinkWrap: true,
//                           physics: NeverScrollableScrollPhysics(),
//                           itemCount: prayerTime!.length,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: const EdgeInsets.only(bottom: 10.0),
//                               child: Container(
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                   color: AppColors.white,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(10.0),
//                                   child: Column(
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 "তারিখ:- ",
//                                                 style: TextFontStyle
//                                                     .textLine12w500Kalpurush
//                                                     .copyWith(
//                                                   color: AppColors.primaryColor,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 16,
//                                                 ),
//                                               ),
//                                               Text(
//                                                 convertToBanglaNumerals(
//                                                     prayerTime[index].date!),
//                                                 style: TextFontStyle
//                                                     .textLine12w500Kalpurush
//                                                     .copyWith(
//                                                   color: AppColors.primaryColor,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 16,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(width: 10),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 "রমজান নং:- ",
//                                                 style: TextFontStyle
//                                                     .textLine12w500Kalpurush
//                                                     .copyWith(
//                                                   color: AppColors.primaryColor,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 16,
//                                                 ),
//                                               ),
//                                               Text(
//                                                 convertToBanglaNumerals(
//                                                   prayerTime[index]
//                                                       .ramjanNo!
//                                                       .toString(),
//                                                 ),
//                                                 style: TextFontStyle
//                                                     .textLine12w500Kalpurush
//                                                     .copyWith(
//                                                   color: AppColors.primaryColor,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 16,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: 10),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         children: [
//                                           PrayerTimeWidget(
//                                             icon: AppIcons.fajr,
//                                             seheriLastTime:
//                                                 prayerTime[index].seheriFinish!,
//                                             iftarTime:
//                                                 prayerTime[index].iftarTime!,
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//                       } else {
//                         return Column(
//                           children: [
//                             Center(
//                               child: Text(
//                                 "দুঃখিত !! নামাযের সময় পাওয়া যায়নি",
//                                 style: TextFontStyle.textLine12w500Kalpurush
//                                     .copyWith(
//                                   color: AppColors.primaryColor,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 26,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                             Lottie.asset(
//                               AppLottie.whiteLottie,
//                               height: 350,
//                               width: 350,
//                             ),
//                           ],
//                         );
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class PrayerTimeWidget extends StatelessWidget {
//   final String seheriLastTime;
//   final String iftarTime;
//   final String icon;

//   const PrayerTimeWidget({
//     required this.icon,
//     required this.seheriLastTime,
//     required this.iftarTime,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             SvgPicture.asset(
//               icon,
//               height: 20,
//               width: 20,
//               color: AppColors.primaryColor,
//             ),
//             SizedBox(
//               width: 20,
//             ),
//             Text(
//               'সেহেরীর শেষ সময়ঃ-' + seheriLastTime,
//               style: TextFontStyle.textLine12w500Kalpurush.copyWith(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             SvgPicture.asset(
//               icon,
//               height: 20,
//               width: 20,
//               color: AppColors.primaryColor,
//             ),
//             SizedBox(
//               width: 20,
//             ),
//             Text(
//               'ইফতারের সময়ঃ-' + iftarTime,
//               style: TextFontStyle.textLine12w500Kalpurush.copyWith(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }