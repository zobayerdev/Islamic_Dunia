import 'package:islamic_dunia/features/explore/presentation/dua/data/get_dua_api.dart';
import 'package:islamic_dunia/features/explore/presentation/dua/model/dua_model.dart';
import 'package:islamic_dunia/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class GetDuaRX extends RxResponseInt<DuaModel> {
  final api = GetDuaApi.instance;

  GetDuaRX({required super.empty, required super.dataFetcher});

  ValueStream<DuaModel> get horseissue => dataFetcher.stream;

  Future<void> duaAPI() async {
    try {
      DuaModel allData = await api.duaAPI();
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
