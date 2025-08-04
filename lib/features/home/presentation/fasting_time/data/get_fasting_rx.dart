import 'package:islamic_dunia/features/home/presentation/fasting_time/data/get_fasting_api.dart';
import 'package:islamic_dunia/features/home/presentation/fasting_time/model/fasting_model.dart';
import 'package:islamic_dunia/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class GetFastingRX extends RxResponseInt<FastingModel> {
  final api = GetFastingAPI.instance;

  GetFastingRX({required super.empty, required super.dataFetcher});

  ValueStream<FastingModel> get horseissue => dataFetcher.stream;

  Future<void> dailyFastingAPI({
    required dynamic lat,
    required dynamic lon,
  }) async {
    try {
      FastingModel allData = await api.dailyFastingAPI(
        lat: lat,
        lon: lon,
      );
      handleSuccessWithReturn(allData);
    } catch (error) {
      handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(dynamic data) {
    dataFetcher.sink.add(data);
    return data;
  }
}
