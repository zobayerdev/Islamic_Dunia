import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:islamic_dunia/features/home/presentation/prayertime/model/home_prayertime_model.dart';
import '../../../networks/exception_handler/data_source.dart';
import '/networks/endpoints.dart';
import '../../../../../../../../networks/dio/dio.dart';

class GetPrayerTimeApi {
  static final GetPrayerTimeApi _singleton = GetPrayerTimeApi._internal();
  GetPrayerTimeApi._internal();

  // Singleton getter
  static GetPrayerTimeApi get instance => _singleton;

  // Method to fetch profile data
  Future<HomePrayerTimeModel> prayerTimeAPI({
    required dynamic lat,
    required dynamic lng,
    required dynamic method,
    required dynamic school,
  }) async {
    try {
      Response response = await getHttp(
        Endpoints.dailyPrayerTime(lat, lng, method, school),
      );

      // Check if the response is successful (HTTP 200)
      if (response.statusCode == 200) {
        Map<String, dynamic> data =
            json.decode(json.encode(response.data)); // Decode the response data
        // Parse the data into a ProfileModel and return it
        return HomePrayerTimeModel.fromJson(data);
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
