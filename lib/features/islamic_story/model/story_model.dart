import 'dart:convert';

class StoryModel {
    final bool? success;
    final List<IslamicStory>? islamicStory;

    StoryModel({
        this.success,
        this.islamicStory,
    });

    factory StoryModel.fromRawJson(String str) => StoryModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
        success: json["success"],
        islamicStory: json["islamic_story"] == null ? [] : List<IslamicStory>.from(json["islamic_story"]!.map((x) => IslamicStory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "islamic_story": islamicStory == null ? [] : List<dynamic>.from(islamicStory!.map((x) => x.toJson())),
    };
}

class IslamicStory {
    final String? id;
    final String? title;
    final String? description;
    final String? reference;
    final DateTime? createdAt;

    IslamicStory({
        this.id,
        this.title,
        this.description,
        this.reference,
        this.createdAt,
    });

    factory IslamicStory.fromRawJson(String str) => IslamicStory.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory IslamicStory.fromJson(Map<String, dynamic> json) => IslamicStory(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        reference: json["reference"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "reference": reference,
        "created_at": createdAt?.toIso8601String(),
    };
}
