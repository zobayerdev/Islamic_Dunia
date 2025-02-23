// ignore_for_file: constant_identifier_names

final class ResponseMessage {
  ResponseMessage._();
  // API response messages
  static const String SUCCESS = "Success"; // Success with data
  static const String NO_CONTENT =
      "Success with no content"; // Success with no data (no content)
  static const String BAD_REQUEST =
      "Bad request. Try again later"; // Failure, API rejected request
  static const String UNAUTORISED =
      "User unauthorized. Try again later"; // Failure, user is not authorized
  static const String FORBIDDEN =
      "Forbidden request. Try again later"; // Failure, API rejected request
  static const String INTERNAL_SERVER_ERROR =
      "Something went wrong. Try again later"; // Failure, crash on the server side
  static const String NOT_FOUND =
      "URL not found. Try again later"; // Failure, resource not found

  // Local status codes
  static const String CONNECT_TIMEOUT = "Timeout. Try again later";
  static const String CANCEL = "Request canceled";
  static const String RECIEVE_TIMEOUT = "Timeout. Try again later";
  static const String SEND_TIMEOUT = "Timeout. Try again later";
  static const String CACHE_ERROR = "Cache error. Try again later";
  static const String NO_INTERNET_CONNECTION =
      "Please check your internet connection";
  static const String DEFAULT = "Something went wrong";
  static const String OTP_VERIFY = "Verify OTP";
  // Add more descriptive comments or documentation as needed
}

final class ResponseCode {
  ResponseCode._();
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTORISED = 401; // failure, user is not authorised
  static const int OTP_VERIFY = 403; //  failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  static const int NOT_FOUND = 404; // failure, not found

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}
