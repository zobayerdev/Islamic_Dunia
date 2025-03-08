import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:islamic_dunia/features/dua/model/dua_model.dart';
import '../../../networks/exception_handler/data_source.dart';
import '/networks/endpoints.dart';
import '../../../../../../../../networks/dio/dio.dart';

class GetDuaApi {
  static final GetDuaApi _singleton = GetDuaApi._internal();
  GetDuaApi._internal();

  // Singleton getter
  static GetDuaApi get instance => _singleton;

  // Method to fetch profile data
  Future<DuaModel> duaAPI() async {
    try {
      Response response = await getHttp(
        Endpoints.duaAPI(),
      );

      // Check if the response is successful (HTTP 200)
      if (response.statusCode == 200) {
        Map<String, dynamic> data =
            json.decode(json.encode(response.data)); // Decode the response data
        // Parse the data into a ProfileModel and return it
        return DuaModel.fromJson(data);
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
