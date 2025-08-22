// import 'package:device_preview/device_preview.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:islamic_dunia/assets_helper/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:provider/provider.dart';
// import 'constants/custome_theme.dart';
// import 'helpers/all_routes.dart';
// import 'helpers/di.dart';
// import 'helpers/helper_methods.dart';
// import 'helpers/navigation_service.dart';
// import 'loading_screen.dart';
// import 'networks/dio/dio.dart';
// import 'package:timezone/data/latest.dart' as tz;

import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:islamic_dunia/loading_screen.dart';
import 'package:provider/provider.dart';
import '/helpers/all_routes.dart';
import 'constants/custome_theme.dart';
import 'helpers/di.dart';
import 'helpers/helper_methods.dart';
import 'helpers/navigation_service.dart';
import 'helpers/register_provider.dart';
import 'networks/dio/dio.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//     DeviceOrientation.landscapeLeft,
//     DeviceOrientation.landscapeRight,
//   ]);
//   tz.initializeTimeZones();
//   //await _requestPermissions();
//   await GetStorage.init();
//   diSetup();

//   // initiInternetChecker();
//   DioSingleton.instance.create();
//   runApp(
//     DevicePreview(
//       enabled: true,
//       builder: (context) => MyApp(), // Wrap your app
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     rotation();
//     setInitValue();
//     return PopScope(
//       canPop: false,
//       // ignore: deprecated_member_use
//       onPopInvoked: (bool didPop) async {
//         showMaterialDialog(context);
//       },
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           return const UtillScreenMobile();
//         },
//       ),
//     );
//   }
// }

// class UtillScreenMobile extends StatelessWidget {
//   const UtillScreenMobile({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       onPopInvokedWithResult: (bool didPop, dynamic d) async {
//         showMaterialDialog(context);
//       },
//       child: MaterialApp(
//         // showPerformanceOverlay: true,
//         theme: ThemeData(
//             unselectedWidgetColor: Colors.white,
//             primarySwatch: CustomTheme.kToDark,
//             useMaterial3: false,
//             scaffoldBackgroundColor: AppColors.whiteColor,
//             appBarTheme:
//                 const AppBarTheme(color: AppColors.whiteColor, elevation: 0)),
//         debugShowCheckedModeBanner: false,
//         builder: (context, widget) {
//           return MediaQuery(data: MediaQuery.of(context), child: widget!);
//         },
//         navigatorKey: NavigationService.navigatorKey,
//         onGenerateRoute: RouteGenerator.generateRoute,
//         home: Loading(),
//         //  home: HomeScreen(),
//       ),
//     );
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  diSetup();
  DioSingleton.instance.create();

  // * run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    rotation();
    setInitValue();
    return MultiProvider(
      providers: providers,
      child: AnimateIfVisibleWrapper(
        showItemInterval: const Duration(milliseconds: 150),
        child: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) async {
            showMaterialDialog(context);
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return const UtillScreenMobile();
            },
          ),
        ),
      ),
    );
  }
}

class UtillScreenMobile extends StatelessWidget {
  const UtillScreenMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) async {
            showMaterialDialog(context);
          },
          child: GetMaterialApp(
            showPerformanceOverlay: false,
            theme: ThemeData(
              primarySwatch: CustomTheme.kToDark,
              scaffoldBackgroundColor: AppColors.scaffoldColor,
              appBarTheme:
                  const AppBarTheme(backgroundColor: AppColors.scaffoldColor),
              useMaterial3: false,
            ),
            debugShowCheckedModeBanner: false,
            builder: (context, widget) {
              return MediaQuery(data: MediaQuery.of(context), child: widget!);
            },
            navigatorKey: NavigationService.navigatorKey,
            onGenerateRoute: RouteGenerator.generateRoute,
            home: const Loading(),
          ),
        );
      },
    );
  }
}
