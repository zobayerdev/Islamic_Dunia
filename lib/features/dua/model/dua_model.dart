import 'dart:convert';

class DuaModel {
    final bool? success;
    final List<Dua>? duas;

    DuaModel({
        this.success,
        this.duas,
    });

    factory DuaModel.fromRawJson(String str) => DuaModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DuaModel.fromJson(Map<String, dynamic> json) => DuaModel(
        success: json["success"],
        duas: json["duas"] == null ? [] : List<Dua>.from(json["duas"]!.map((x) => Dua.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "duas": duas == null ? [] : List<dynamic>.from(duas!.map((x) => x.toJson())),
    };
}

class Dua {
    final int? id;
    final String? title;
    final String? content;
    final String? arabic;
    final String? banglaMeaning;
    final String? reference;

    Dua({
        this.id,
        this.title,
        this.content,
        this.arabic,
        this.banglaMeaning,
        this.reference,
    });

    factory Dua.fromRawJson(String str) => Dua.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Dua.fromJson(Map<String, dynamic> json) => Dua(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        arabic: json["arabic"],
        banglaMeaning: json["bangla_meaning"],
        reference: json["reference"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "arabic": arabic,
        "bangla_meaning": banglaMeaning,
        "reference": reference,
    };
}
