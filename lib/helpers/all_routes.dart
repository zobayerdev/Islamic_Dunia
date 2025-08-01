import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:islamic_dunia/features/explore/presentation/allah_name/presentation/allah_name_screen.dart';
import 'package:islamic_dunia/features/explore/presentation/daily_ayat/presentation/daily_ayat_details_screen.dart';
import 'package:islamic_dunia/features/explore/presentation/daily_ayat/presentation/daily_ayat_screen.dart';
import 'package:islamic_dunia/features/explore/presentation/dua/presentation/dua_screen.dart';
import 'package:islamic_dunia/features/explore/presentation/hadis/presentation/hadis_screen.dart';
import 'package:islamic_dunia/features/islamic_books/books_view_screen.dart';
import 'package:islamic_dunia/features/home/presentation/prayertime/presentation/prayer_time_screen.dart';
import 'package:islamic_dunia/features/quran_pdf/quran_pdf_screen.dart';
import 'package:islamic_dunia/features/explore/presentation/ramadan/presentation/ramadan_screen.dart';
import 'package:islamic_dunia/features/explore/presentation/surah/presentatioon/details_surah_screen.dart';
import 'package:islamic_dunia/features/explore/presentation/surah/presentatioon/surah_screen.dart';
import 'package:islamic_dunia/features/explore/presentation/tashbih/tasbih_screen.dart';
import 'package:islamic_dunia/navigation_screen.dart';

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
  static const String dailyAyatScreen = '/dailyAyatScreen';
  static const String dailyAyatDetailsScreen = '/dailyAyatDetailsScreen';
  static const String tasbihScreen = '/tasbihScreen';
  static const String pdfViewScreen = '/pdfViewScreen';
  static const String homeScreen = '/homeScreen';
  static const String navigationScreen = '/navigationScreen';
}

final class RouteGenerator {
  static final RouteGenerator _routeGenerator = RouteGenerator._internal();
  RouteGenerator._internal();
  static RouteGenerator get instance => _routeGenerator;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // * Home Screen
      case Routes.navigationScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: NavigationScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => NavigationScreen());

      // * Prayer Time Screen
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
                  sBangla: args['sBangla'],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => SurahDetailsScreen(
                  sName: args['sName'],
                  sBangla: args['sBangla'],
                ),
              );

      case Routes.dailyAyatScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: DailyAyatScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => DailyAyatScreen());

      case Routes.dailyAyatDetailsScreen:
        final Map args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: DailyAyatDetailsScreen(
                  title: args['title'],
                  description: args['description'],
                  imageURL: args['imageURL'],
                  reference: args['reference'],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => DailyAyatDetailsScreen(
                  title: args['title'],
                  description: args['description'],
                  imageURL: args['imageURL'],
                  reference: args['reference'],
                ),
              );

      // * tashbih app
      case Routes.tasbihScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: TasbihHomePage(), settings: settings)
            : CupertinoPageRoute(builder: (context) => TasbihHomePage());

      // * pdf view screen
      case Routes.pdfViewScreen:
        final Map args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: PDFViewScreen(
                  pdfURL: args['pdfURL'],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => PDFViewScreen(
                  pdfURL: args['pdfURL'],
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
