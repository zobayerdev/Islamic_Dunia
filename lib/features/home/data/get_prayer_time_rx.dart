import 'package:islamic_dunia/features/home/data/get_prayer_time_api.dart';
import 'package:islamic_dunia/features/home/model/prayer_time_model.dart';
import 'package:islamic_dunia/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class GetPrayerTimeRX extends RxResponseInt<PrayerTimeModel> {
  final api = GetPrayerTimeApi.instance;

  GetPrayerTimeRX({required super.empty, required super.dataFetcher});

  ValueStream<PrayerTimeModel> get horseissue => dataFetcher.stream;

  Future<void> prayerTimeAPI() async {
    try {
      PrayerTimeModel allData = await api.prayerTimeAPI();
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
