import 'dart:convert';

class SurahModel {
    String? message;
    int? number;
    List<SurahList>? surahList;

    SurahModel({
        this.message,
        this.number,
        this.surahList,
    });

    factory SurahModel.fromRawJson(String str) => SurahModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SurahModel.fromJson(Map<String, dynamic> json) => SurahModel(
        message: json["message"],
        number: json["number"],
        surahList: json["surahList"] == null ? [] : List<SurahList>.from(json["surahList"]!.map((x) => SurahList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "number": number,
        "surahList": surahList == null ? [] : List<dynamic>.from(surahList!.map((x) => x.toJson())),
    };
}

class SurahList {
    int? number;
    String? name;
    String? bangla;
    String? source;

    SurahList({
        this.number,
        this.name,
        this.bangla,
        this.source,
    });

    factory SurahList.fromRawJson(String str) => SurahList.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SurahList.fromJson(Map<String, dynamic> json) => SurahList(
        number: json["number"],
        name: json["name"],
        bangla: json["bangla"],
        source: json["source"],
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "name": name,
        "bangla": bangla,
        "source": source,
    };
}
