import 'package:islamic_dunia/features/islamic_books/data/get_books_api.dart';
import 'package:islamic_dunia/features/islamic_books/model/books_model.dart';
import 'package:islamic_dunia/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class GetBookRX extends RxResponseInt<BookModel> {
  final api = GetBookApi.instance;

  GetBookRX({required super.empty, required super.dataFetcher});

  ValueStream<BookModel> get horseissue => dataFetcher.stream;

  Future<void> bookAPI() async {
    try {
      BookModel allData = await api.bookAPI();
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
