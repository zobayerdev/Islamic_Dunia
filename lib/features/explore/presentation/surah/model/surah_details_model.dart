import 'dart:convert';

class SurahDetailModel {
    String? surahName;
    int? verse;
    String? audio;
    String? bismillah;
    List<Surah>? surah;

    SurahDetailModel({
        this.surahName,
        this.verse,
        this.audio,
        this.bismillah,
        this.surah,
    });

    factory SurahDetailModel.fromRawJson(String str) => SurahDetailModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SurahDetailModel.fromJson(Map<String, dynamic> json) => SurahDetailModel(
        surahName: json["surahName"],
        verse: json["verse"],
        audio: json["audio"],
        bismillah: json["bismillah"],
        surah: json["surah"] == null ? [] : List<Surah>.from(json["surah"]!.map((x) => Surah.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "surahName": surahName,
        "verse": verse,
        "audio": audio,
        "bismillah": bismillah,
        "surah": surah == null ? [] : List<dynamic>.from(surah!.map((x) => x.toJson())),
    };
}

class Surah {
    int? verse;
    String? arabic;
    String? bangla;
    String? english;

    Surah({
        this.verse,
        this.arabic,
        this.bangla,
        this.english,
    });

    factory Surah.fromRawJson(String str) => Surah.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        verse: json["verse"],
        arabic: json["arabic"],
        bangla: json["bangla"],
        english: json["english"],
    );

    Map<String, dynamic> toJson() => {
        "verse": verse,
        "arabic": arabic,
        "bangla": bangla,
        "english": english,
    };
}
