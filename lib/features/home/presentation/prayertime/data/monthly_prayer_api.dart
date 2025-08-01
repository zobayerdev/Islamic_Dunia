import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:islamic_dunia/features/home/presentation/prayertime/model/monthly_pray_model.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '/networks/endpoints.dart';
import '../../../../../../../../../../networks/dio/dio.dart';

class GetMonthlyPrayerTimeApi {
  static final GetMonthlyPrayerTimeApi _singleton =
      GetMonthlyPrayerTimeApi._internal();
  GetMonthlyPrayerTimeApi._internal();

  // Singleton getter
  static GetMonthlyPrayerTimeApi get instance => _singleton;

  // Method to fetch profile data
  Future<MonthlyPrayTimeModel> monthPrayerTimeAPI() async {
    try {
      Response response = await getHttp(
        Endpoints.monthPrayerTimeAPI(),
      );

      // Check if the response is successful (HTTP 200)
      if (response.statusCode == 200) {
        Map<String, dynamic> data =
            json.decode(json.encode(response.data)); // Decode the response data
        // Parse the data into a ProfileModel and return it
        return MonthlyPrayTimeModel.fromJson(data);
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
