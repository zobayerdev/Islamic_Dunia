import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:islamic_dunia/features/allah_name/presentation/allah_name_screen.dart';
import 'package:islamic_dunia/features/dua/presentation/dua_screen.dart';
import 'package:islamic_dunia/features/hadis/presentation/hadis_screen.dart';
import 'package:islamic_dunia/features/prayertime/presentation/prayer_time_screen.dart';
import 'package:islamic_dunia/features/quran_pdf/quran_pdf_screen.dart';
import 'package:islamic_dunia/features/ramadan/presentation/ramadan_screen.dart';
import 'package:islamic_dunia/features/surah/presentatioon/details_surah_screen.dart';
import 'package:islamic_dunia/features/surah/presentatioon/surah_screen.dart';

final class Routes {
  static final Routes _routes = Routes._internal();
  Routes._internal();
  static Routes get instance => _routes;

  // ################## Auth User ##################
  static const String logInUserScreen = '/logInUserScreen';
  static const String prayerTimeScreen = '/prayerTimeScreen';
  static const String surahScreen = '/surahScreen';
  static const String surahDetailsScreen = '/surahDetailsScreen';
  static const String hadisDetailsScreen = '/hadisDetailsScreen';
  static const String duaDetailsScreen = '/duaDetailsScreen';
  static const String allahNameScreen = '/allahNameScreen';
  static const String quranPDFScreen = '/quranPDFScreen';
  static const String ramadanScreen = '/ramadanScreen';
}

final class RouteGenerator {
  static final RouteGenerator _routeGenerator = RouteGenerator._internal();
  RouteGenerator._internal();
  static RouteGenerator get instance => _routeGenerator;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.prayerTimeScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: PrayerTimeScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => PrayerTimeScreen());

      case Routes.surahScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: SsurahScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => SsurahScreen());

      case Routes.hadisDetailsScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: HadisScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => HadisScreen());

      case Routes.duaDetailsScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: DuaScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => DuaScreen());

      case Routes.allahNameScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: AllahNameScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => AllahNameScreen());

      case Routes.quranPDFScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: QuranPDFScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => QuranPDFScreen());

      case Routes.ramadanScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: RamadanScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => RamadanScreen());

      case Routes.surahDetailsScreen:
        final Map args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: SurahDetailsScreen(
                  sName: args['sName'],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => SurahDetailsScreen(
                  sName: args['sName'],
                ),
              );

      default:
        return null;
    }
  }
}

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({required this.widget, required this.settings})
      : super(
          settings: settings,
          reverseTransitionDuration: const Duration(milliseconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: const Duration(milliseconds: 1),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.ease,
              ),
              child: child,
            );
          },
        );
}

class ScreenTitle extends StatelessWidget {
  final Widget widget;

  const ScreenTitle({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: .5, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceIn,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: widget,
    );
  }
}
