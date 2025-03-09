// import 'dart:convert';

// class AllahModel {
//   int? response;
//   String? allahModelResponse;
//   List<Datum>? data;

//   AllahModel({
//     this.response,
//     this.allahModelResponse,
//     this.data,
//   });

//   factory AllahModel.fromRawJson(String str) =>
//       AllahModel.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory AllahModel.fromJson(Map<String, dynamic> json) => AllahModel(
//         response: json["Response"],
//         allahModelResponse: json["response"],
//         data: json["data"] == null
//             ? []
//             : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "Response": response,
//         "response": allahModelResponse,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }

// class Datum {
//   int? id;
//   String? arabic;
//   String? bangla;
//   String? english;
//   String? meaning;

//   Datum({
//     this.id,
//     this.arabic,
//     this.bangla,
//     this.english,
//     this.meaning,
//   });

//   factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         arabic: json["arabic"],
//         bangla: json["bangla"],
//         english: json["english"],
//         meaning: json["meaning"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "arabic": arabic,
//         "bangla": bangla,
//         "english": english,
//         "meaning": meaning,
//       };
// }

import 'dart:convert';

class AllahModel {
  List<Main>? main;

  AllahModel({
    this.main,
  });

  factory AllahModel.fromRawJson(String str) =>
      AllahModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllahModel.fromJson(Map<String, dynamic> json) => AllahModel(
        main: json["main"] == null
            ? []
            : List<Main>.from(json["main"]!.map((x) => Main.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "main": main == null
            ? []
            : List<dynamic>.from(main!.map((x) => x.toJson())),
      };
}

class Main {
  String? id;
  String? arName;
  String? enName;
  String? meaning;
  String? explanation;
  String? benefit;

  Main({
    this.id,
    this.arName,
    this.enName,
    this.meaning,
    this.explanation,
    this.benefit,
  });

  factory Main.fromRawJson(String str) => Main.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        id: json["id"],
        arName: json["arName"],
        enName: json["enName"],
        meaning: json["meaning"],
        explanation: json["explanation"],
        benefit: json["benefit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "arName": arName,
        "enName": enName,
        "meaning": meaning,
        "explanation": explanation,
        "benefit": benefit,
      };
}
