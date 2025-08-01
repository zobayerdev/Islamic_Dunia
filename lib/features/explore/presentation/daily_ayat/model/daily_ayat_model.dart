import 'dart:convert';

class DailyAyatModel {
    final bool? success;
    final List<DailyAyat>? dailyAyats;

    DailyAyatModel({
        this.success,
        this.dailyAyats,
    });

    factory DailyAyatModel.fromRawJson(String str) => DailyAyatModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DailyAyatModel.fromJson(Map<String, dynamic> json) => DailyAyatModel(
        success: json["success"],
        dailyAyats: json["daily_ayats"] == null ? [] : List<DailyAyat>.from(json["daily_ayats"]!.map((x) => DailyAyat.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "daily_ayats": dailyAyats == null ? [] : List<dynamic>.from(dailyAyats!.map((x) => x.toJson())),
    };
}

class DailyAyat {
    final int? id;
    final String? title;
    final String? imagePath;
    final String? description;
    final String? reference;

    DailyAyat({
        this.id,
        this.title,
        this.imagePath,
        this.description,
        this.reference,
    });

    factory DailyAyat.fromRawJson(String str) => DailyAyat.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DailyAyat.fromJson(Map<String, dynamic> json) => DailyAyat(
        id: json["id"],
        title: json["title"],
        imagePath: json["image_path"],
        description: json["description"],
        reference: json["reference"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image_path": imagePath,
        "description": description,
        "reference": reference,
    };
}
