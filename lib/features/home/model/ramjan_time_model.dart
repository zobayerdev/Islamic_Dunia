// To parse this JSON data, do
//
//     final ramjanTimeModel = ramjanTimeModelFromJson(jsonString);

import 'dart:convert';

RamjanTimeModel ramjanTimeModelFromJson(String str) => RamjanTimeModel.fromJson(json.decode(str));

String ramjanTimeModelToJson(RamjanTimeModel data) => json.encode(data.toJson());

class RamjanTimeModel {
    String? status;
    String? message;
    List<Datum>? data;

    RamjanTimeModel({
        this.status,
        this.message,
        this.data,
    });

    factory RamjanTimeModel.fromJson(Map<String, dynamic> json) => RamjanTimeModel(
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
    int? ramjanNo;
    String? seheriStart;
    String? seheriFinish;
    String? iftarTime;
    String? date;
    String? dayName;

    Datum({
        this.id,
        this.ramjanNo,
        this.seheriStart,
        this.seheriFinish,
        this.iftarTime,
        this.date,
        this.dayName,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        ramjanNo: json["ramjan_no"],
        seheriStart: json["seheri_start"],
        seheriFinish: json["seheri_finish"],
        iftarTime: json["iftar_time"],
        date: json["date"],
        dayName: json["day_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ramjan_no": ramjanNo,
        "seheri_start": seheriStart,
        "seheri_finish": seheriFinish,
        "iftar_time": iftarTime,
        "date": date,
        "day_name": dayName,
    };
}
