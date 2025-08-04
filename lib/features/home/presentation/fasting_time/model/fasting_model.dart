import 'dart:convert';

class FastingModel {
    final int? code;
    final String? status;
    final String? range;
    final Data? data;

    FastingModel({
        this.code,
        this.status,
        this.range,
        this.data,
    });

    factory FastingModel.fromRawJson(String str) => FastingModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FastingModel.fromJson(Map<String, dynamic> json) => FastingModel(
        code: json["code"],
        status: json["status"],
        range: json["range"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "range": range,
        "data": data?.toJson(),
    };
}

class Data {
    final List<Fasting>? fasting;
    final WhiteDays? whiteDays;

    Data({
        this.fasting,
        this.whiteDays,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        fasting: json["fasting"] == null ? [] : List<Fasting>.from(json["fasting"]!.map((x) => Fasting.fromJson(x))),
        whiteDays: json["white_days"] == null ? null : WhiteDays.fromJson(json["white_days"]),
    );

    Map<String, dynamic> toJson() => {
        "fasting": fasting == null ? [] : List<dynamic>.from(fasting!.map((x) => x.toJson())),
        "white_days": whiteDays?.toJson(),
    };
}

class Fasting {
    final DateTime? date;
    final String? hijri;
    final String? hijriReadable;
    final Time? time;

    Fasting({
        this.date,
        this.hijri,
        this.hijriReadable,
        this.time,
    });

    factory Fasting.fromRawJson(String str) => Fasting.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Fasting.fromJson(Map<String, dynamic> json) => Fasting(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        hijri: json["hijri"],
        hijriReadable: json["hijri_readable"],
        time: json["time"] == null ? null : Time.fromJson(json["time"]),
    );

    Map<String, dynamic> toJson() => {
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "hijri": hijri,
        "hijri_readable": hijriReadable,
        "time": time?.toJson(),
    };
}

class Time {
    final String? sahur;
    final String? iftar;
    final String? duration;

    Time({
        this.sahur,
        this.iftar,
        this.duration,
    });

    factory Time.fromRawJson(String str) => Time.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Time.fromJson(Map<String, dynamic> json) => Time(
        sahur: json["sahur"],
        iftar: json["iftar"],
        duration: json["duration"],
    );

    Map<String, dynamic> toJson() => {
        "sahur": sahur,
        "iftar": iftar,
        "duration": duration,
    };
}

class WhiteDays {
    final String? status;
    final Days? days;

    WhiteDays({
        this.status,
        this.days,
    });

    factory WhiteDays.fromRawJson(String str) => WhiteDays.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory WhiteDays.fromJson(Map<String, dynamic> json) => WhiteDays(
        status: json["status"],
        days: json["days"] == null ? null : Days.fromJson(json["days"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "days": days?.toJson(),
    };
}

class Days {
    final DateTime? the13Th;
    final DateTime? the14Th;
    final DateTime? the15Th;

    Days({
        this.the13Th,
        this.the14Th,
        this.the15Th,
    });

    factory Days.fromRawJson(String str) => Days.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Days.fromJson(Map<String, dynamic> json) => Days(
        the13Th: json["13th"] == null ? null : DateTime.parse(json["13th"]),
        the14Th: json["14th"] == null ? null : DateTime.parse(json["14th"]),
        the15Th: json["15th"] == null ? null : DateTime.parse(json["15th"]),
    );

    Map<String, dynamic> toJson() => {
        "13th": "${the13Th!.year.toString().padLeft(4, '0')}-${the13Th!.month.toString().padLeft(2, '0')}-${the13Th!.day.toString().padLeft(2, '0')}",
        "14th": "${the14Th!.year.toString().padLeft(4, '0')}-${the14Th!.month.toString().padLeft(2, '0')}-${the14Th!.day.toString().padLeft(2, '0')}",
        "15th": "${the15Th!.year.toString().padLeft(4, '0')}-${the15Th!.month.toString().padLeft(2, '0')}-${the15Th!.day.toString().padLeft(2, '0')}",
    };
}
