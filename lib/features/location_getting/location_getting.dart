// ignore_for_file: unused_import
// * ################################################################################################################
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:islamic_dunia/assets_helper/app_fonts.dart';
import 'package:islamic_dunia/assets_helper/app_images.dart';
import 'package:islamic_dunia/assets_helper/app_lottie.dart';
import 'package:islamic_dunia/common_widgets/custom_appbar.dart';
import 'package:islamic_dunia/common_widgets/custom_button.dart';
import 'package:islamic_dunia/constants/app_constants.dart';
import 'package:islamic_dunia/helpers/all_routes.dart';
import 'package:islamic_dunia/helpers/di.dart';
import 'package:islamic_dunia/helpers/navigation_service.dart';
import 'package:islamic_dunia/helpers/ui_helpers.dart';
import 'package:lottie/lottie.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationPrinterScreen extends StatefulWidget {
  @override
  _LocationPrinterScreenState createState() => _LocationPrinterScreenState();
}

class _LocationPrinterScreenState extends State<LocationPrinterScreen> {
  String? latitude = "লোকেশন পাওয়া যায়নি।";
  String? longitude = "";
  String? address = "";
  String? timezone = "";
  String? utcOffset = "";
  bool isLoading = false;
  String? selectedMethodName;
  int? selectedMethodId;
  String? selectedSchoolName;
  int? selectedSchoolId;

  // প্রার্থনা সময় গণনার পদ্ধতির তালিকা
  final Map<int, String> prayerMethods = {
    0: 'Jafari / Shia Ithna-Ashari',
    1: 'University of Islamic Sciences, Karachi',
    2: 'Islamic Society of North America',
    3: 'Muslim World League',
    4: 'Umm Al-Qura University, Makkah',
    5: 'Egyptian General Authority of Survey',
    7: 'Institute of Geophysics, Tehran',
    8: 'Gulf Region',
    9: 'Kuwait',
    10: 'Qatar',
    11: 'MUIS, Singapore',
    12: 'UOIF, France',
    13: 'Diyanet, Turkey',
    14: 'Russia',
    15: 'Moonsighting Committee Worldwide',
    16: 'Dubai (experimental)',
    17: 'JAKIM, Malaysia',
    18: 'Tunisia',
    19: 'Algeria',
    20: 'KEMENAG, Indonesia',
    21: 'Morocco',
    22: 'Lisbon, Portugal',
    23: 'Jordan',
  };

  // প্রার্থনার স্কুল তালিকা
  final Map<int, String> schoolMethods = {
    1: 'Shafi',
    2: 'Hanafi',
  };

  @override
  void initState() {
    super.initState();
    getLocationAddressAndTimezone();
    // ডিফল্ট হিসেবে University of Islamic Sciences, Karachi এবং Shafi সিলেক্ট করা
    selectedMethodName = prayerMethods[1];
    selectedMethodId = 1;
    selectedSchoolName = schoolMethods[1];
    selectedSchoolId = 1;
  }

  Future<void> getLocationAddressAndTimezone() async {
    setState(() {
      isLoading = true;
    });

    // লোকেশন সার্ভিস চেক করা
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        latitude = "লোকেশন সার্ভিস বন্ধ আছে।";
        longitude = "দয়া করে লোকেশন চালু করুন।";
        address = "";
        timezone = "";
        utcOffset = "";
        isLoading = false;
      });
      return;
    }

    // লোকেশন পারমিশন চেক এবং রিকোয়েস্ট
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          latitude = "লোকেশন পারমিশন প্রত্যাখ্যান করা হয়েছে।";
          longitude = "";
          address = "";
          timezone = "";
          utcOffset = "";
          isLoading = false;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        latitude = "লোকেশন পারমিশন স্থায়ীভাবে প্রত্যাখ্যান করা হয়েছে।";
        longitude = "দয়া করে সেটিংস থেকে পারমিশন দিন।";
        address = "";
        timezone = "";
        utcOffset = "";
        isLoading = false;
      });
      return;
    }

    // লোকেশন পাওয়া
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');

      // রিভার্স জিওকোডিং: ঠিকানা পাওয়া
      String tempAddress = "ঠিকানা পাওয়া যায়নি।";
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        if (placemarks.isNotEmpty) {
          Placemark placemark = placemarks.first;
          tempAddress = [
            placemark.street,
            placemarks.length > 1 ? placemarks[1].subLocality : null,
            placemark.locality,
            placemark.administrativeArea,
            placemark.country,
          ]
              .where((element) => element != null && element.isNotEmpty)
              .join(', ');
          print('ঠিকানা: $tempAddress');
        }
      } catch (e) {
        print('জিওকোডিং ত্রুটি: $e');
        tempAddress = "জিওকোডিং ত্রুটি: $e";
      }

      // টাইমজোন পাওয়া
      String tempTimezone = "টাইমজোন পাওয়া যায়নি।";
      String tempUtcOffset = "";
      try {
        final response = await http.get(Uri.parse(
          'http://api.timezonedb.com/v2.1/get-time-zone?key=GP5D7J3QX05G&format=json&by=position&lat=${position.latitude}&lng=${position.longitude}',
        ));

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          tempTimezone = data['zoneName'] ?? "টাইমজোন পাওয়া যায়নি।";
          int offsetSeconds = data['gmtOffset'] ?? 0;
          int hours = (offsetSeconds / 3600).floor();
          int minutes = ((offsetSeconds % 3600) / 60).abs().toInt();
          tempUtcOffset =
              'UTC${hours >= 0 ? '+' : ''}$hours:${minutes.toString().padLeft(2, '0')}';
          print('টাইমজোন: $tempTimezone, UTC Offset: $tempUtcOffset');
        } else {
          print('টাইমজোন API ত্রুটি: Status ${response.statusCode}');
          tempTimezone = "টাইমজোন API ত্রুটি।";
        }
      } catch (e) {
        print('টাইমজোন পেতে ত্রুটি: $e');
        tempTimezone = "টাইমজোন পেতে ত্রুটি: $e";
      }

      setState(() {
        latitude = "${position.latitude}";
        longitude = "${position.longitude}";
        address = "$tempAddress";
        timezone = "$tempTimezone";
        utcOffset = "$tempUtcOffset";
        isLoading = false;
      });
    } catch (e) {
      print('লোকেশন পেতে ত্রুটি: $e');
      setState(() {
        latitude = "লোকেশন পেতে ত্রুটি: $e";
        longitude = "";
        address = "";
        timezone = "";
        utcOffset = "";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cDCE4E6.withOpacity(0.9),
      appBar: CustomAppBar(
        title: 'লোকেশন, ঠিকানা এবং টাইমজোন',
        leadingIconUnVisible: true,
      ),
      body: Center(
        child: isLoading
            ? Lottie.asset(
                AppLottie.whiteLottie,
                height: 250,
                width: 250,
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(UIHelper.kDefaultPadding()),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          AppImages.bgImages,
                          height: 150,
                          width: 150,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'আপনার লোকেশন',
                        style: TextFontStyle.textLine12w500Kalpurush
                            .copyWith(fontSize: 15),
                      ),
                      Text(
                        address ?? "",
                        style: TextFontStyle.smallStyle10w400Poppins.copyWith(
                          fontSize: 13,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'টাইমজোন:- ',
                            style: TextFontStyle.textLine12w500Kalpurush
                                .copyWith(fontSize: 15),
                          ),
                          Text(
                            timezone ?? "",
                            style: TextFontStyle.smallStyle10w400Poppins
                                .copyWith(fontSize: 15),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'টাইমজোন এরিয়া:- ',
                            style: TextFontStyle.textLine12w500Kalpurush
                                .copyWith(fontSize: 15),
                          ),
                          Text(
                            utcOffset ?? "",
                            style: TextFontStyle.smallStyle10w400Poppins
                                .copyWith(fontSize: 15),
                          ),
                        ],
                      ),
                      UIHelper.verticalSpace(12),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'নামাযের সময় ক্যালকুলেশন',
                          style: TextFontStyle.textLine12w500Kalpurush
                              .copyWith(fontSize: 22),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        'আপনি আপনার প্রয়োজনীয় ক্যালকুলেশন পদ্ধতি এবং মাজহাব নির্বাচন করুন যেটা আপনার জন্য উপযুক্ত।',
                        style: TextFontStyle.textLine12w500Kalpurush
                            .copyWith(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 28),

                      // * প্রার্থনা পদ্ধতি নির্বাচন করুন
                      DropdownButtonFormField<String>(
                        value: selectedMethodName,
                        decoration: InputDecoration(
                          labelText: 'ক্যালকুলেশন পদ্ধতি নির্বাচন করুন',
                          labelStyle:
                              TextFontStyle.textLine12w500Kalpurush.copyWith(
                            fontSize: 18,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12.0,
                          ),
                        ),
                        isExpanded: true,
                        items: prayerMethods.values.map((String methodName) {
                          return DropdownMenuItem<String>(
                            value: methodName,
                            child: Text(
                              methodName,
                              style: TextFontStyle.smallStyle10w400Poppins
                                  .copyWith(
                                fontSize: 15,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedMethodName = newValue;
                              selectedMethodId = prayerMethods.keys.firstWhere(
                                (key) => prayerMethods[key] == newValue,
                                orElse: () => 1,
                              );
                              print(
                                  'ID: $selectedMethodId, নাম: $selectedMethodName');
                            });
                          }
                        },
                      ),
                      SizedBox(height: 20),

                      // * মাজহাব নির্বাচন করুন
                      DropdownButtonFormField<String>(
                        value: selectedSchoolName,
                        decoration: InputDecoration(
                          labelText: 'মাজহাব নির্বাচন করুন',
                          labelStyle:
                              TextFontStyle.textLine12w500Kalpurush.copyWith(
                            fontSize: 18,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12.0,
                          ),
                        ),
                        isExpanded: true,
                        items: schoolMethods.values.map((String schoolName) {
                          return DropdownMenuItem<String>(
                            value: schoolName,
                            child: Text(
                              schoolName,
                              style: TextFontStyle.smallStyle10w400Poppins
                                  .copyWith(
                                fontSize: 15,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedSchoolName = newValue;
                              selectedSchoolId = schoolMethods.keys.firstWhere(
                                (key) => schoolMethods[key] == newValue,
                                orElse: () => 1,
                              );
                              print(
                                  'ID: $selectedSchoolId, নাম: $selectedSchoolName');
                            });
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      customButton(
                        name: 'সেভ করে রাখুন',
                        textStyle:
                            TextFontStyle.textLine12w500Kalpurush.copyWith(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        onCallBack: () {
                          appData.write(kKeySelectedAddress, address);
                          appData.write(kKeyTimeZone, timezone);
                          appData.write(kKeyTimeZoneArea, utcOffset);
                          appData.write(kKeyLatitude, latitude);
                          appData.write(kKeyLongitude, longitude);
                          appData.write(kKeySchool, selectedSchoolId);
                          appData.write(kKeyCalculation, selectedMethodId);
                          appData.write(kKeyIsExploring, true);
                          NavigationService.navigateTo(
                            Routes.navigationScreen,
                          );

                          log('=====> $address');
                          log('=====> $timezone');
                          log('=====> $utcOffset');
                          log('=====> $latitude');
                          log('=====> $longitude');
                          log('=====> $selectedSchoolId');
                          log('=====> $selectedMethodId');
                        },
                        context: context,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getLocationAddressAndTimezone,
        child: Icon(Icons.refresh),
        tooltip: 'লোকেশন, ঠিকানা এবং টাইমজোন রিফ্রেশ',
      ),
    );
  }
}
