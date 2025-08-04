import 'package:islamic_dunia/features/islamic_story/data/get_story_api.dart';
import 'package:islamic_dunia/features/islamic_story/model/story_model.dart';
import 'package:islamic_dunia/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class GetStoryRX extends RxResponseInt<StoryModel> {
  final api = GetStoryAPI.instance;

  GetStoryRX({required super.empty, required super.dataFetcher});

  ValueStream<StoryModel> get horseissue => dataFetcher.stream;

  Future<void> storyAPI() async {
    try {
      StoryModel allData = await api.storyAPI();
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
