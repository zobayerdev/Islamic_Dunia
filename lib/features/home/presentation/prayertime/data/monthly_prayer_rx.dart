import 'package:islamic_dunia/features/home/presentation/prayertime/data/monthly_prayer_api.dart';
import 'package:islamic_dunia/features/home/presentation/prayertime/model/monthly_pray_model.dart';
import 'package:islamic_dunia/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class GetMonthlyPrayerTimeRX extends RxResponseInt<MonthlyPrayTimeModel> {
  final api = GetMonthlyPrayerTimeApi.instance;

  GetMonthlyPrayerTimeRX({required super.empty, required super.dataFetcher});

  ValueStream<MonthlyPrayTimeModel> get horseissue => dataFetcher.stream;

  Future<void> monthPrayerTimeAPI() async {
    try {
      MonthlyPrayTimeModel allData = await api.monthPrayerTimeAPI();
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
