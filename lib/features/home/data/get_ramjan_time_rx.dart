import 'package:islamic_dunia/features/home/data/get_ramjan_time_api.dart';
import 'package:islamic_dunia/features/home/model/ramjan_time_model.dart';
import 'package:islamic_dunia/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class GetRamjanTimeRX extends RxResponseInt<RamjanTimeModel> {
  final api = GetRamjanTimeApi.instance;

  GetRamjanTimeRX({required super.empty, required super.dataFetcher});

  ValueStream<RamjanTimeModel> get horseissue => dataFetcher.stream;

  Future<void> ramjanTimeAPI() async {
    try {
      RamjanTimeModel allData = await api.ramjanTimeAPI();
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
