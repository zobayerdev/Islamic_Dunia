import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:islamic_dunia/features/home/presentation/fasting_time/model/fasting_model.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '/networks/endpoints.dart';
import '../../../../../../../../../../networks/dio/dio.dart';

class GetFastingAPI {
  static final GetFastingAPI _singleton = GetFastingAPI._internal();
  GetFastingAPI._internal();

  // Singleton getter
  static GetFastingAPI get instance => _singleton;

  // Method to fetch profile data
  Future<FastingModel> dailyFastingAPI({
    required dynamic lat,
    required dynamic lon,
  }) async {
    try {
      Response response = await getHttp(
        Endpoints.dailyFastingAPI(lat, lon),
      );

      // Check if the response is successful (HTTP 200)
      if (response.statusCode == 200) {
        Map<String, dynamic> data =
            json.decode(json.encode(response.data)); // Decode the response data
        // Parse the data into a ProfileModel and return it
        return FastingModel.fromJson(data);
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
