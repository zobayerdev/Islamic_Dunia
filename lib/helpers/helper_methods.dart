// ignore_for_file: use_build_context_synchronously, unused_local_variable, avoid_print

import 'dart:async';
import 'dart:io';
import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
import '/helpers/di.dart';
import '../common_widgets/custom_button.dart';
import '../constants/app_constants.dart';
import 'package:islamic_dunia/assets_helper/app_fonts.dart';


//final appData = locator.get<GetStorage>();
// final plcaeMarkAddress = locator.get<PlcaeMarkAddress>();
//declared for cart scrren calling bottom shit with this from reorder rx
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final GlobalKey<PopupMenuButtonState<String>> popUpGlobalkey =
    GlobalKey<PopupMenuButtonState<String>>();

enum StatusType { order, delivery }

String language(String languageKey) {
  late String language;

  switch (languageKey) {
    case kKeyEnglish:
      language = "English";
      break;
    case kKeyFrench:
      language = "French";
      break;
    case kKeyGerman:
      language = "Dutch";
      break;
    case kKeyRussian:
      language = "Russian";
      break;
    case kKeyPortuguese:
      language = "Portuguese";
      break;
    case kKeySpanish:
      language = "Spanish";
      break;
    default:
      language = "Portuguese";
  }
  return language;
}

// Future<String?> networkImageToBase64(String imageUrl) async {
//   http.Response response = await http.get(Uri.parse(imageUrl));
//   final bytes = response.bodyBytes;

//   // ignore: unnecessary_null_comparison
//   return (bytes != null ? base64Encode(bytes) : null);
// }

Future<void> setInitValue() async {
  appData.writeIfNull(kKeyfirstTime, true);
  await appData.writeIfNull(kKeyIsLoggedIn, false);
  await appData.writeIfNull(kKeyIsExploring, false);
  // this is a temporary token. which should be removed

  // DioSingleton.instance.update(
  //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL21vbGxpZS5taW5kYm9zc2NvYWNoaW5nLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MjM0MzMwMTQsImV4cCI6MTcyNDAzNzgxNCwibmJmIjoxNzIzNDMzMDE0LCJqdGkiOiJQUlVxOHFoN2JnR0hyUEwyIiwic3ViIjoiMTYiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.SDEYU_UyYKWdDRW1NHQbbbmEgqAM64HE-b4_PVbSLoM");
//lisbon
  // appData.writeIfNull(kKeySelectedLat, 38.74631383626653);
  // appData.writeIfNull(kKeySelectedLng, -9.130169921874991);
//codemen

  // var deviceInfo = DeviceInfoPlugin();
  // if (Platform.isIOS) {
  //   var iosDeviceInfo = await deviceInfo.iosInfo;
  //   appData.writeIfNull(
  //       kKeyDeviceID, iosDeviceInfo.identifierForVendor); // unique ID on iOS
  // } else if (Platform.isAndroid) {
  //   var androidDeviceInfo =
  //       await deviceInfo.androidInfo; // unique ID on Android
  //   appData.writeIfNull(kKeyDeviceID, androidDeviceInfo.id);
  // }
  await Future.delayed(const Duration(seconds: 2));
}

// Future<void> initiInternetChecker() async {
//   InternetConnectionChecker.createInstance(
//           checkTimeout: const Duration(seconds: 1),
//           checkInterval: const Duration(seconds: 2))
//       .onStatusChange
//       .listen((status) {
//     switch (status) {
//       case InternetConnectionStatus.connected:
//         ToastUtil.showShortToast('Data connection is available.');
//         break;
//       case InternetConnectionStatus.disconnected:
//         ToastUtil.showNoInternetToast();
//         break;
//     }
//   });
// }

Completer<T> wrapInCompleter<T>(Future<T> future) {
  final completer = Completer<T>();
  future.then(completer.complete).catchError(completer.completeError);
  return completer;
}

Future<void> getInvisible() async {
  Future.delayed(const Duration(milliseconds: 500), () {});
}

// GoogleSignIn googleSignIn = GoogleSignIn(
//   scopes: [],
// );

void loginWithSocialMedia(String driver) async {
  String userId, name, email;

  try {
    if (driver == kGoogle) {
      //    googleSignIn.signOut();
      /// final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();
    } else if (driver == kFacebook) {
      // FacebookLoginResult loginResult = await facebookLogin.logIn(['email']);
      // switch (loginResult.status) {
      //   case FacebookLoginStatus.cancelledByUser:
      //     return;

      //   case FacebookLoginStatus.error:
      //     throw Exception(loginResult.errorMessage);
      //     break;

      //   case FacebookLoginStatus.loggedIn:
      //     final token = loginResult.accessToken.token;
      //     final graphResponse = await http.get(
      //       Uri.parse(
      //           'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token'),
      //     );
      //     final profile = json.decode(graphResponse.body);

      //     if (profile != null) {
      //       userId = profile['id'];
      //       name = profile['name'];
      //       email = profile['email'];
      //     }
      //     break;

      //   default:
      //     break;
      // }
    } else if (driver == kApple) {
      // final credential = await SignInWithApple.getAppleIDCredential(
      //   scopes: [
      //     AppleIDAuthorizationScopes.email,
      //     AppleIDAuthorizationScopes.fullName,
      //   ],
      // );
      // print(credential);

      // if (credential.userIdentifier != null) {
      //   await postSocailLoginRXObj.postSocailLogin(
      //       socialAuthId: credential.userIdentifier!,
      //       email: credential.email,
      //       firstName: credential.givenName,
      //       lastName: credential.familyName,
      //       registerType: "4");
      // }
    }
  } catch (e) {
    // ToastUtil.showLongToast(e.toString());
  }
}

Future<File> getLocalFile(String filename) async {
  File f = File(filename);
  return f;
}

void showMaterialDialog(
  BuildContext context,
) {
  showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              "Do you want to exit the app?",
              textAlign: TextAlign.center,
              style: TextFontStyle.textStyle14w400Poppins,
            ),
            actions: <Widget>[
              customButton(
                  name: "No".tr,
                  onCallBack: () {
                    Navigator.of(context).pop(false);
                  },
                  height: 30,
                  minWidth: .3,
                  borderRadius: 30,
                  color: AppColors.cF0F0F0,
                  textStyle:TextFontStyle.textStyle17w700Poppins,
                  context: context),
              customButton(
                  name: "Yes".tr,
                  onCallBack: () {
                    if (Platform.isAndroid) {
                      SystemNavigator.pop();
                    } else if (Platform.isIOS) {
                      exit(0);
                    }
                  },
                  height: 30,
                  minWidth: .3,
                  borderRadius: 30,
                  color: AppColors.primaryColor,
                  textStyle:TextFontStyle.textStyle17w700Poppins,
                  context: context,),
            ],
          ));
}

void rotation() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color.fromARGB(80, 0, 0, 0),
    statusBarIconBrightness: Brightness.light,
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
