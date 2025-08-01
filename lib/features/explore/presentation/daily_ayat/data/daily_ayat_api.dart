import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:islamic_dunia/features/explore/presentation/daily_ayat/model/daily_ayat_model.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '/networks/endpoints.dart';
import '../../../../../../../../../../networks/dio/dio.dart';

class GetDailyAyatAPI {
  static final GetDailyAyatAPI _singleton = GetDailyAyatAPI._internal();
  GetDailyAyatAPI._internal();

  // Singleton getter
  static GetDailyAyatAPI get instance => _singleton;

  // Method to fetch profile data
  Future<DailyAyatModel> dailyAyatAPI() async {
    try {
      Response response = await getHttp(
        Endpoints.dailyAyatAPI(),
      );

      // * Check if the response is successful (HTTP 200)
      if (response.data["success"] == true) {
        Map<String, dynamic> data =
            json.decode(json.encode(response.data)); // Decode the response data
        // Parse the data into a ProfileModel and return it
        return DailyAyatModel.fromJson(data);
      } else {
        // Handle non-200 status code errors, like 404, 500, etc.
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors (like network failures, timeouts, etc.)
      throw ErrorHandler.handle(error).failure;
    }
  }
}
