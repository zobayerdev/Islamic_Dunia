import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:islamic_dunia/features/explore/presentation/surah/model/surah_details_model.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '/networks/endpoints.dart';
import '../../../../../../../../../../networks/dio/dio.dart';

class GetSurahDetailsApi {
  static final GetSurahDetailsApi _singleton = GetSurahDetailsApi._internal();
  GetSurahDetailsApi._internal();

  // Singleton getter
  static GetSurahDetailsApi get instance => _singleton;

  // Method to fetch profile data
  Future<SurahDetailModel> surahDetailAPI(dynamic surahName) async {
    try {
      Response response = await getHttp(
        Endpoints.surahDetailAPI(surahName),
      );

      // Check if the response is successful (HTTP 200)
      if (response.statusCode == 200) {
        Map<String, dynamic> data =
            json.decode(json.encode(response.data)); // Decode the response data
        // Parse the data into a ProfileModel and return it
        return SurahDetailModel.fromJson(data);
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
