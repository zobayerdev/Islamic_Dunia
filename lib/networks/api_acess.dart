import 'package:islamic_dunia/features/allah_name/data/get_name_rx.dart';
import 'package:islamic_dunia/features/allah_name/model/allah_model.dart';
import 'package:islamic_dunia/features/daily_ayat/data/daily_ayat_rx.dart';
import 'package:islamic_dunia/features/daily_ayat/model/daily_ayat_model.dart';
import 'package:islamic_dunia/features/dua/data/get_dua_rx.dart';
import 'package:islamic_dunia/features/dua/model/dua_model.dart';
import 'package:islamic_dunia/features/hadis/data/get_hadis_rx.dart';
import 'package:islamic_dunia/features/hadis/widget/hadis_model.dart';
import 'package:islamic_dunia/features/home/data/get_prayer_time_rx.dart';
import 'package:islamic_dunia/features/home/data/get_ramjan_time_rx.dart';
import 'package:islamic_dunia/features/home/model/prayer_time_model.dart';
import 'package:islamic_dunia/features/home/model/ramjan_time_model.dart';
import 'package:islamic_dunia/features/prayertime/data/monthly_prayer_rx.dart';
import 'package:islamic_dunia/features/prayertime/model/monthly_pray_model.dart';
import 'package:islamic_dunia/features/surah/data/get_surah_details_rx.dart';
import 'package:islamic_dunia/features/surah/data/get_surah_rx.dart';
import 'package:islamic_dunia/features/surah/model/surah_details_model.dart';
import 'package:islamic_dunia/features/surah/model/surah_model.dart';
import 'package:rxdart/rxdart.dart';

GetPrayerTimeRX getPrayerTimeRX = GetPrayerTimeRX(
  empty: PrayerTimeModel(),
  dataFetcher: BehaviorSubject<PrayerTimeModel>(),
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
