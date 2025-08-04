import 'package:islamic_dunia/features/home/data/get_prayer_time_api.dart';
import 'package:islamic_dunia/features/home/presentation/prayertime/model/home_prayertime_model.dart';
import 'package:islamic_dunia/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class GetPrayerTimeRX extends RxResponseInt<HomePrayerTimeModel> {
  final api = GetPrayerTimeApi.instance;

  GetPrayerTimeRX({required super.empty, required super.dataFetcher});

  ValueStream<HomePrayerTimeModel> get horseissue => dataFetcher.stream;

  Future<void> prayerTimeAPI({
    required dynamic lat,
    required dynamic lng,
    required dynamic method,
    required dynamic school,
  }) async {
    try {
      HomePrayerTimeModel allData = await api.prayerTimeAPI(
          lat: lat, lng: lng, method: method, school: school);
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
