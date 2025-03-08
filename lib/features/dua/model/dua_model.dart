import 'dart:convert';

class DuaModel {
    String? status;
    String? message;
    List<Datum>? data;

    DuaModel({
        this.status,
        this.message,
        this.data,
    });

    factory DuaModel.fromRawJson(String str) => DuaModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DuaModel.fromJson(Map<String, dynamic> json) => DuaModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? id;
    String? title;
    String? arabic;
    String? bangla;
    String? banglaAnubad;
    String? english;
    String? reference;

    Datum({
        this.id,
        this.title,
        this.arabic,
        this.bangla,
        this.banglaAnubad,
        this.english,
        this.reference,
    });

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        arabic: json["arabic"],
        bangla: json["bangla"],
        banglaAnubad: json["bangla_anubad"],
        english: json["english"],
        reference: json["reference"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "arabic": arabic,
        "bangla": bangla,
        "bangla_anubad": banglaAnubad,
        "english": english,
        "reference": reference,
    };
}
