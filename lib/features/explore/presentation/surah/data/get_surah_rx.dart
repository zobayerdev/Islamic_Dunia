import 'package:islamic_dunia/features/explore/presentation/surah/data/get_surah_api.dart';
import 'package:islamic_dunia/features/explore/presentation/surah/model/surah_model.dart';
import 'package:islamic_dunia/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class GetSurahRX extends RxResponseInt<SurahModel> {
  final api = GetSurahApi.instance;

  GetSurahRX({required super.empty, required super.dataFetcher});

  ValueStream<SurahModel> get horseissue => dataFetcher.stream;

  Future<void> surahAPI() async {
    try {
      SurahModel allData = await api.surahAPI();
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
