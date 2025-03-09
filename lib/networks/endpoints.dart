// // ignore_for_file: constant_identifier_names

// const String url = "";

// final class NetworkConstants {
//   NetworkConstants._();
//   static const ACCEPT = "Accept";
//   static const APP_KEY = "9fdea5d82cmshd2d3441bdacf198p189145jsn4c124d6a44d3";
//   static const ACCEPT_LANGUAGE = "Accept-Language";
//   static const ACCEPT_LANGUAGE_VALUE = "pt";
//   static const APP_KEY_VALUE = String.fromEnvironment(
//       "9fdea5d82cmshd2d3441bdacf198p189145jsn4c124d6a44d3");
//   static const ACCEPT_TYPE = "application/json";
//   static const AUTHORIZATION = "Authorization";
//   static const CONTENT_TYPE = "content-Type";
//   static const x_rapidapi_ua = "RapidAPI-Playground";
//   static const x_rapidapi_host = "online-quran-api.p.rapidapi.com";
// }

// final class PaymentGateway {
//   PaymentGateway._();
//   static String gateway(String orderId) => "";
// }

// final class Endpoints {
//   Endpoints._();
//   //backend_url
//   static String prayerTimeAPI() =>
//       "https://muslimsalat.com//bangladesh/daily.json?key=b14e849e4c8659e734283102b44d0d2d";

//   static String monthPrayerTimeAPI() =>
//       "https://muslimsalat.com/bangladesh/monthly.json?key=b14e849e4c8659e734283102b44d0d2d";

//   static String ramjanTimeAPI() =>
//       "https://www.zobayerdev.top/islamic_dunia/ramjan_time/read_timings.php";

//   static String surahAPI() => "https://online-quran-api.p.rapidapi.com/surahs";

//   // static String logIn() => "/api/login";
//   // static String resendEmailVarificationOtp() =>
//   //     "/api/resend-email-verification-otp";
//   // static String verifyCode() => "/api/verify-email";
//   // static String logout() => "/api/logout";
//   // static String forgotPasswordEmail() => "/api/forget-password";
//   // static String verifyOtpFP() => "/api/verify-otp";
//   // static String profile() => "/api/profile/details";
//   // static String updateProfile() => "/api/profile/update";
//   // static String getAllRemainders() => "/api/reminder";
//   // static String addNewRemainder() => "/api/reminder";
//   // static String remainder(String slug) => "/api/reminder/$slug";
//   // static String deleteRemainder(int slug) => "/api/reminder/$slug";
//   // static String updateRemainder(int slug) => "/api/reminder/$slug";
//   // static String resetPassword() => "/api/reset-password";
//   // static String changeStatus(int slug) => "/api/reminder/status/$slug";
//   // static String categoryByType() => "/api/category-type";
//   // static String quoteListByCategoryWithIdes(ids) =>
//   //     "/api/quote?per_page=1000&page=1&categories=$ids";
//   // static String quoteAllList() => "/api/quote?per_page=1000&page=1";
//   // static String favQuote() => "/api/favourite/quote";
//   // static String addQuote() => "/api/personal-quote";
//   // static String deleteFavQuote() => "/api/favourite/quote/remove";
//   // static String theme() => "/api/theme";
//   // static String personalQuote() => "/api/personal-quote";
//   // static String deleteMyQuote(int slug) => "/api/personal-quote/$slug";
// }

// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';

const String url = "";

final class NetworkConstants {
  NetworkConstants._();
  static const ACCEPT = "Accept";
  static const APP_KEY = "x-rapidapi-key"; // Your API Key
  static const APP_KEY_VALUE =
      "9fdea5d82cmshd2d3441bdacf198p189145jsn4c124d6a44d3";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
  static const x_rapidapi_ua = "RapidAPI-Playground";
  static const x_rapidapi_host = "online-quran-api.p.rapidapi.com";
  static const x_rapidapi_allah = "allah-name.p.rapidapi.com";
}

final class PaymentGateway {
  PaymentGateway._();
  static String gateway(String orderId) => "";
}

final class Endpoints {
  Endpoints._();
  static String prayerTimeAPI() =>
      "https://muslimsalat.com//bangladesh/daily.json?key=b14e849e4c8659e734283102b44d0d2d";

  static String monthPrayerTimeAPI() =>
      "https://muslimsalat.com/bangladesh/monthly.json?key=b14e849e4c8659e734283102b44d0d2d";

  static String ramjanTimeAPI() =>
      "https://www.zobayerdev.top/islamic_dunia/ramjan_time/read_timings.php";

  static String surahAPI() => "https://online-quran-api.p.rapidapi.com/surahs";

  static String surahDetailAPI(dynamic surahName) =>
      "https://online-quran-api.p.rapidapi.com/surahs/$surahName";

  static String hadisAPI() =>
      "https://www.zobayerdev.top/islamic_dunia/hadis_section/read_hadiths.php";

  static String duaAPI() =>
      "https://www.zobayerdev.top/islamic_dunia/dua_section/read_duas.php";

  static String allahNameAPI() => "https://allah-name.p.rapidapi.com/name";
}

// API Service Class
class ApiService {
  final Dio _dio = Dio();

  Future<void> fetchSurahs() async {
    try {
      Response response = await _dio.get(
        Endpoints.surahAPI(),
        options: Options(
          headers: {
            NetworkConstants.ACCEPT: NetworkConstants.ACCEPT_TYPE,
            "x-rapidapi-key":
                NetworkConstants.APP_KEY, // Using API key from constants
            "x-rapidapi-host": NetworkConstants.x_rapidapi_host,
          },
        ),
      );

      // Print the response data
      print("Success: ${response.data}");
    } on DioException catch (e) {
      // Handle API errors
      if (e.response != null) {
        print("Error Response: ${e.response!.data}");
      } else {
        print("Dio Error: ${e.message}");
      }
    } catch (e) {
      print("Unexpected Error: $e");
    }
  }
}

// API Service Class
class ApiService_Allah {
  final Dio _dio = Dio();

  Future<void> fetchSurahs() async {
    try {
      Response response = await _dio.get(
        Endpoints.surahAPI(),
        options: Options(
          headers: {
            NetworkConstants.ACCEPT: NetworkConstants.ACCEPT_TYPE,
            "x-rapidapi-key":
                NetworkConstants.APP_KEY, // Using API key from constants
            "x-rapidapi-host": NetworkConstants.x_rapidapi_host,
          },
        ),
      );

      // Print the response data
      print("Success: ${response.data}");
    } on DioException catch (e) {
      // Handle API errors
      if (e.response != null) {
        print("Error Response: ${e.response!.data}");
      } else {
        print("Dio Error: ${e.message}");
      }
    } catch (e) {
      print("Unexpected Error: $e");
    }
  }
}

void main() {
  ApiService apiService = ApiService();
  apiService.fetchSurahs();
}
