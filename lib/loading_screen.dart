import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:islamic_dunia/features/location_getting/location_getting.dart';
import 'package:islamic_dunia/navigation_screen.dart';
import 'package:islamic_dunia/networks/api_acess.dart';
import 'constants/app_constants.dart';

import 'helpers/di.dart';
import 'helpers/helper_methods.dart';
import 'networks/dio/dio.dart';
import 'welcome_screen.dart';

final class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool _isLoading = true;
  bool isFirstTime = false;

  @override
  void initState() {
    loadInitialData();
    super.initState();
  }

  loadInitialData() async {
    //AutoAppUpdateUtil.instance.checkAppUpdate();
    await setInitValue();

    await getPrayerTimeRX.prayerTimeAPI();
    await getBookRX.bookAPI();

    if (appData.read(kKeyIsLoggedIn)) {
      String token = appData.read(kKeyAccessToken);
      DioSingleton.instance.update(token);
    } else {
      //  NotificationService().cancelAllNotifications();
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const WelcomeScreen();
    } else {
      // Print kKeyIsExploring value to console
      log('kKeyIsExploring: ${appData.read(kKeyIsExploring)}');
      return appData.read(kKeyIsLoggedIn)
          ? WelcomeScreen()
          : appData.read(kKeyIsExploring)
              ? NavigationScreen()
              : DistrictSelector();
    }
  }
}
