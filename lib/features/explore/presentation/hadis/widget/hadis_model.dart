// import 'dart:convert';

// class HadisModel {
//     String? status;
//     String? message;
//     int? code;
//     List<Datum>? data;

//     HadisModel({
//         this.status,
//         this.message,
//         this.code,
//         this.data,
//     });

//     factory HadisModel.fromRawJson(String str) => HadisModel.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory HadisModel.fromJson(Map<String, dynamic> json) => HadisModel(
//         status: json["status"],
//         message: json["message"],
//         code: json["code"],
//         data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "code": code,
//         "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//     };
// }

// class Datum {
//     int? id;
//     String? title;
//     String? arabic;
//     String? bangla;
//     String? banglaAnubad;
//     String? english;
//     String? reference;

//     Datum({
//         this.id,
//         this.title,
//         this.arabic,
//         this.bangla,
//         this.banglaAnubad,
//         this.english,
//         this.reference,
//     });

//     factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         title: json["title"],
//         arabic: json["arabic"],
//         bangla: json["bangla"],
//         banglaAnubad: json["bangla_anubad"],
//         english: json["english"],
//         reference: json["reference"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "arabic": arabic,
//         "bangla": bangla,
//         "bangla_anubad": banglaAnubad,
//         "english": english,
//         "reference": reference,
//     };
// }

import 'dart:convert';

class HadisModel {
  final bool? success;
  final List<Hadith>? hadiths;

  HadisModel({
    this.success,
    this.hadiths,
  });

  factory HadisModel.fromRawJson(String str) =>
      HadisModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HadisModel.fromJson(Map<String, dynamic> json) => HadisModel(
        success: json["success"],
        hadiths: json["hadiths"] == null
            ? []
            : List<Hadith>.from(
                json["hadiths"]!.map((x) => Hadith.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "hadiths": hadiths == null
            ? []
            : List<dynamic>.from(hadiths!.map((x) => x.toJson())),
      };
}

class Hadith {
  final int? id;
  final String? title;
  final String? content;
  final String? arabic;
  final String? banglaMeaning;
  final String? reference;

  Hadith({
    this.id,
    this.title,
    this.content,
    this.arabic,
    this.banglaMeaning,
    this.reference,
  });

  factory Hadith.fromRawJson(String str) => Hadith.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Hadith.fromJson(Map<String, dynamic> json) => Hadith(
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
