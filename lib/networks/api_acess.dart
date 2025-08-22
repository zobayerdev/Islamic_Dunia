import 'package:islamic_dunia/features/explore/presentation/allah_name/data/get_name_rx.dart';
import 'package:islamic_dunia/features/explore/presentation/allah_name/model/allah_model.dart';
import 'package:islamic_dunia/features/explore/presentation/daily_ayat/data/daily_ayat_rx.dart';
import 'package:islamic_dunia/features/explore/presentation/daily_ayat/model/daily_ayat_model.dart';
import 'package:islamic_dunia/features/explore/presentation/dua/data/get_dua_rx.dart';
import 'package:islamic_dunia/features/explore/presentation/dua/model/dua_model.dart';
import 'package:islamic_dunia/features/explore/presentation/hadis/data/get_hadis_rx.dart';
import 'package:islamic_dunia/features/explore/presentation/hadis/widget/hadis_model.dart';
import 'package:islamic_dunia/features/home/data/get_prayer_time_rx.dart';
import 'package:islamic_dunia/features/home/data/get_ramjan_time_rx.dart';
import 'package:islamic_dunia/features/home/model/ramjan_time_model.dart';
import 'package:islamic_dunia/features/home/presentation/fasting_time/data/get_fasting_rx.dart';
import 'package:islamic_dunia/features/home/presentation/fasting_time/model/fasting_model.dart';
import 'package:islamic_dunia/features/home/presentation/prayertime/model/home_prayertime_model.dart';
import 'package:islamic_dunia/features/islamic_books/data/get_books_rx.dart';
import 'package:islamic_dunia/features/islamic_books/model/books_model.dart';
import 'package:islamic_dunia/features/home/presentation/prayertime/data/monthly_prayer_rx.dart';
import 'package:islamic_dunia/features/home/presentation/prayertime/model/monthly_pray_model.dart';
import 'package:islamic_dunia/features/explore/presentation/surah/data/get_surah_details_rx.dart';
import 'package:islamic_dunia/features/explore/presentation/surah/data/get_surah_rx.dart';
import 'package:islamic_dunia/features/explore/presentation/surah/model/surah_details_model.dart';
import 'package:islamic_dunia/features/explore/presentation/surah/model/surah_model.dart';
import 'package:islamic_dunia/features/home/presentation/islamic_story/data/get_story_rx.dart';
import 'package:islamic_dunia/features/home/presentation/islamic_story/model/story_model.dart';
import 'package:rxdart/rxdart.dart';

GetPrayerTimeRX getPrayerTimeRX = GetPrayerTimeRX(
  empty: HomePrayerTimeModel(),
  dataFetcher: BehaviorSubject<HomePrayerTimeModel>(),
);

GetFastingRX getFastingRX = GetFastingRX(
  empty: FastingModel(),
  dataFetcher: BehaviorSubject<FastingModel>(),
);

GetMonthlyPrayerTimeRX getMonthlyPrayerTimeRX = GetMonthlyPrayerTimeRX(
  empty: MonthlyPrayTimeModel(),
  dataFetcher: BehaviorSubject<MonthlyPrayTimeModel>(),
);

GetRamjanTimeRX getRamjanTimeRX = GetRamjanTimeRX(
  empty: RamjanTimeModel(),
  dataFetcher: BehaviorSubject<RamjanTimeModel>(),
);

GetSurahRX getSurahRX = GetSurahRX(
  empty: SurahModel(),
  dataFetcher: BehaviorSubject<SurahModel>(),
);

GetSurahDetailsRX getSurahDetailsRX = GetSurahDetailsRX(
  empty: SurahDetailModel(),
  dataFetcher: BehaviorSubject<SurahDetailModel>(),
);

GetHadisRX getHadisRX = GetHadisRX(
  empty: HadisModel(),
  dataFetcher: BehaviorSubject<HadisModel>(),
);

GetDuaRX getDuaRX = GetDuaRX(
  empty: DuaModel(),
  dataFetcher: BehaviorSubject<DuaModel>(),
);

GetAllahNameRX getAllahNameRX = GetAllahNameRX(
  empty: AllahModel(),
  dataFetcher: BehaviorSubject<AllahModel>(),
);

GetDailyAyatAPIRX getDailyAyatAPIRX = GetDailyAyatAPIRX(
  empty: DailyAyatModel(),
  dataFetcher: BehaviorSubject<DailyAyatModel>(),
);

GetBookRX getBookRX = GetBookRX(
  empty: BookModel(),
  dataFetcher: BehaviorSubject<BookModel>(),
);

GetStoryRX getStoryRX = GetStoryRX(
  empty: StoryModel(),
  dataFetcher: BehaviorSubject<StoryModel>(),
);