import 'package:islamic_dunia/features/explore/presentation/hadis/data/get_hadis_api.dart';
import 'package:islamic_dunia/features/explore/presentation/hadis/widget/hadis_model.dart';
import 'package:islamic_dunia/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class GetHadisRX extends RxResponseInt<HadisModel> {
  final api = GetHadisApi.instance;

  GetHadisRX({required super.empty, required super.dataFetcher});

  ValueStream<HadisModel> get horseissue => dataFetcher.stream;

  Future<void> hadisAPI() async {
    try {
      HadisModel allData = await api.hadisAPI();
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
