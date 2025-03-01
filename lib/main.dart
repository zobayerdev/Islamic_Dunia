import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'constants/custome_theme.dart';
import 'helpers/all_routes.dart';
import 'helpers/di.dart';
import 'helpers/helper_methods.dart';
import 'helpers/navigation_service.dart';
import 'loading_screen.dart';
import 'networks/dio/dio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //await _requestPermissions();
  await GetStorage.init();
  diSetup();

  // initiInternetChecker();
  DioSingleton.instance.create();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    rotation();
    setInitValue();
    return PopScope(
      canPop: false,
      // ignore: deprecated_member_use
      onPopInvoked: (bool didPop) async {
        showMaterialDialog(context);
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return const UtillScreenMobile();
        },
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
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic d) async {
        showMaterialDialog(context);
      },
      child: MaterialApp(
        //    showPerformanceOverlay: true,
        theme: ThemeData(
            unselectedWidgetColor: Colors.white,
            primarySwatch: CustomTheme.kToDark,
            useMaterial3: false,
            scaffoldBackgroundColor: AppColors.whiteColor,
            appBarTheme:
                const AppBarTheme(color: AppColors.whiteColor, elevation: 0)),
        debugShowCheckedModeBanner: false,
        builder: (context, widget) {
          return MediaQuery(data: MediaQuery.of(context), child: widget!);
        },
        navigatorKey: NavigationService.navigatorKey,
        onGenerateRoute: RouteGenerator.generateRoute,
        home: Loading(),
        //  home: HomeScreen(),
      ),
    );
  }
}
