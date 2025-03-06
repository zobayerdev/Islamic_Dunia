// ignore_for_file: constant_identifier_names

const String url = "";

final class NetworkConstants {
  NetworkConstants._();
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

final class PaymentGateway {
  PaymentGateway._();
  static String gateway(String orderId) => "";
}

final class Endpoints {
  Endpoints._();
  //backend_url
  static String prayerTimeAPI() =>
      "https://muslimsalat.com//bangladesh/daily.json?key=b14e849e4c8659e734283102b44d0d2d";
      
  static String monthPrayerTimeAPI() =>
      "https://muslimsalat.com/bangladesh/monthly.json?key=b14e849e4c8659e734283102b44d0d2d";

  static String ramjanTimeAPI() =>
      "https://www.zobayerdev.top/islamic_dunia/ramjan_time/read_timings.php";

  // static String logIn() => "/api/login";
  // static String resendEmailVarificationOtp() =>
  //     "/api/resend-email-verification-otp";
  // static String verifyCode() => "/api/verify-email";
  // static String logout() => "/api/logout";
  // static String forgotPasswordEmail() => "/api/forget-password";
  // static String verifyOtpFP() => "/api/verify-otp";
  // static String profile() => "/api/profile/details";
  // static String updateProfile() => "/api/profile/update";
  // static String getAllRemainders() => "/api/reminder";
  // static String addNewRemainder() => "/api/reminder";
  // static String remainder(String slug) => "/api/reminder/$slug";
  // static String deleteRemainder(int slug) => "/api/reminder/$slug";
  // static String updateRemainder(int slug) => "/api/reminder/$slug";
  // static String resetPassword() => "/api/reset-password";
  // static String changeStatus(int slug) => "/api/reminder/status/$slug";
  // static String categoryByType() => "/api/category-type";
  // static String quoteListByCategoryWithIdes(ids) =>
  //     "/api/quote?per_page=1000&page=1&categories=$ids";
  // static String quoteAllList() => "/api/quote?per_page=1000&page=1";
  // static String favQuote() => "/api/favourite/quote";
  // static String addQuote() => "/api/personal-quote";
  // static String deleteFavQuote() => "/api/favourite/quote/remove";
  // static String theme() => "/api/theme";
  // static String personalQuote() => "/api/personal-quote";
  // static String deleteMyQuote(int slug) => "/api/personal-quote/$slug";
}
