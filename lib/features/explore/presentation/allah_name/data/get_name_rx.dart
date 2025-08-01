import 'package:islamic_dunia/features/explore/presentation/allah_name/data/get_name_api.dart';
import 'package:islamic_dunia/features/explore/presentation/allah_name/model/allah_model.dart';
import 'package:islamic_dunia/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class GetAllahNameRX extends RxResponseInt<AllahModel> {
  final api = GetAllahNameApi.instance;

  GetAllahNameRX({required super.empty, required super.dataFetcher});

  ValueStream<AllahModel> get horseissue => dataFetcher.stream;

  Future<void> allahNameAPI() async {
    try {
      AllahModel allData = await api.allahNameAPI();
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
