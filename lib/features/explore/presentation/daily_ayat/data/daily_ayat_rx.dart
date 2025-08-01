import 'package:islamic_dunia/features/explore/presentation/daily_ayat/data/daily_ayat_api.dart';
import 'package:islamic_dunia/features/explore/presentation/daily_ayat/model/daily_ayat_model.dart';
import 'package:islamic_dunia/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class GetDailyAyatAPIRX extends RxResponseInt<DailyAyatModel> {
  final api = GetDailyAyatAPI.instance;

  GetDailyAyatAPIRX({required super.empty, required super.dataFetcher});

  ValueStream<DailyAyatModel> get horseissue => dataFetcher.stream;

  Future<void> dailyAyatAPI() async {
    try {
      DailyAyatModel allData = await api.dailyAyatAPI();
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
