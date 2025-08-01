import 'package:islamic_dunia/features/explore/presentation/surah/data/get_surah_details_api.dart';
import 'package:islamic_dunia/features/explore/presentation/surah/model/surah_details_model.dart';
import 'package:islamic_dunia/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class GetSurahDetailsRX extends RxResponseInt<SurahDetailModel> {
  final api = GetSurahDetailsApi.instance;

  GetSurahDetailsRX({required super.empty, required super.dataFetcher});

  ValueStream<SurahDetailModel> get horseissue => dataFetcher.stream;

  Future<void> surahDetailAPI(dynamic surahName) async {
    try {
      SurahDetailModel allData = await api.surahDetailAPI(surahName);
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
