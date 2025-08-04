import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:islamic_dunia/assets_helper/app_fonts.dart';
import 'package:islamic_dunia/assets_helper/app_images.dart';
import 'package:islamic_dunia/assets_helper/app_lottie.dart';
import 'package:islamic_dunia/common_widgets/custom_appbar.dart';
import 'package:islamic_dunia/constants/app_constants.dart';
import 'package:islamic_dunia/features/home/presentation/prayertime/model/home_prayertime_model.dart';
import 'package:islamic_dunia/helpers/di.dart';
import 'package:islamic_dunia/networks/api_acess.dart';
import 'package:islamic_dunia/prayer_timer_screen.dart';
import 'package:lottie/lottie.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math.dart' as vmath;

class QiblaCompassScreen extends StatefulWidget {
  @override
  _QiblaCompassScreenState createState() => _QiblaCompassScreenState();
}

class _QiblaCompassScreenState extends State<QiblaCompassScreen> {
  double? _qiblaDirection;
  double? _distanceToMakkah;
  Position? _currentPosition;
  String _status = "Loading location...";
  // * read data from appData
  late final dynamic latitude,
      longitude,
      timeZone,
      timeZoneArea,
      school,
      address,
      calculation;

  @override
  void initState() {
    super.initState();
    _initLocationAndQibla();

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
  }

  Future<void> _initLocationAndQibla() async {
    try {
      // Permission request
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      // Get current location
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Makkah Location
      const makkahLat = 21.4225;
      const makkahLng = 39.8262;

      // Calculate Qibla Direction
      double qibla =
          _calculateQiblaDirection(position.latitude, position.longitude);

      // Calculate Distance
      double distance = _calculateDistance(
          position.latitude, position.longitude, makkahLat, makkahLng);

      setState(() {
        _currentPosition = position;
        _qiblaDirection = qibla;
        _distanceToMakkah = distance;
        _status = "মক্কা থেকে আপনার দূরত্ব";
      });
    } catch (e) {
      setState(() {
        _status = "Error getting location: ${e.toString()}";
      });
    }
  }

  double _calculateQiblaDirection(double lat, double lon) {
    const makkahLat = 21.4225;
    const makkahLon = 39.8262;

    double phiK = vmath.radians(makkahLat);
    double lambdaK = vmath.radians(makkahLon);
    double phi = vmath.radians(lat);
    double lambda = vmath.radians(lon);

    double qibla = vmath.degrees(
      math.atan2(
        math.sin(lambdaK - lambda),
        math.cos(phi) * math.tan(phiK) -
            math.sin(phi) * math.cos(lambdaK - lambda),
      ),
    );

    return (qibla + 360) % 360;
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const earthRadius = 6371; // in KM

    double dLat = _degToRad(lat2 - lat1);
    double dLon = _degToRad(lon2 - lon1);

    double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_degToRad(lat1)) *
            math.cos(_degToRad(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);

    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadius * c;
  }

  double _degToRad(double deg) => deg * math.pi / 180;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'কিবলা কম্পাস',
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
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: _qiblaDirection == null || _currentPosition == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text(_status),
                        ],
                      )
                    : Column(
                        children: [
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
                          StreamBuilder<CompassEvent>(
                            stream: FlutterCompass.events,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text("Compass not available");
                              }

                              double direction = snapshot.data!.heading ?? 0;

                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "কিবলার সাথে সামঞ্জস্য রাখতে আপনার ফোনটি ঘোরান",
                                    style: TextFontStyle.textLine12w500Kalpurush
                                        .copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Center(child: Text("N")),
                                      Transform.rotate(
                                        angle: vmath.radians(
                                            (_qiblaDirection! - direction)),
                                        child: Image.asset(
                                          AppImages.qiblaImage,
                                          height: 300,
                                          width: 300,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30),
                                  Text(
                                    "$_status",
                                    style: TextFontStyle.textLine12w500Kalpurush
                                        .copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${_distanceToMakkah!.toStringAsFixed(2)} কিলোমিটার",
                                    style: TextFontStyle.textLine12w500Kalpurush
                                        .copyWith(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
