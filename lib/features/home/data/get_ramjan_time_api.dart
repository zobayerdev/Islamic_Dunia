import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:islamic_dunia/features/home/model/ramjan_time_model.dart';
import '../../../networks/exception_handler/data_source.dart';
import '/networks/endpoints.dart';
import '../../../../../../../../networks/dio/dio.dart';

class GetRamjanTimeApi {
  static final GetRamjanTimeApi _singleton = GetRamjanTimeApi._internal();
  GetRamjanTimeApi._internal();

  // Singleton getter
  static GetRamjanTimeApi get instance => _singleton;

  // Method to fetch profile data
  Future<RamjanTimeModel> ramjanTimeAPI() async {
    try {
      Response response = await getHttp(
        Endpoints.ramjanTimeAPI(),
      );

      // Check if the response is successful (HTTP 200)
      if (response.statusCode == 200) {
        Map<String, dynamic> data =
            json.decode(json.encode(response.data)); // Decode the response data
        // Parse the data into a ProfileModel and return it
        return RamjanTimeModel.fromJson(data);
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
