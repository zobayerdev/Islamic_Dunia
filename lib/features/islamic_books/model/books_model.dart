import 'dart:convert';

class BookModel {
    final bool? success;
    final List<IslamicBook>? islamicBooks;

    BookModel({
        this.success,
        this.islamicBooks,
    });

    factory BookModel.fromRawJson(String str) => BookModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        success: json["success"],
        islamicBooks: json["islamic_books"] == null ? [] : List<IslamicBook>.from(json["islamic_books"]!.map((x) => IslamicBook.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "islamic_books": islamicBooks == null ? [] : List<dynamic>.from(islamicBooks!.map((x) => x.toJson())),
    };
}

class IslamicBook {
    final int? id;
    final String? title;
    final String? description;
    final String? filePath;

    IslamicBook({
        this.id,
        this.title,
        this.description,
        this.filePath,
    });

    factory IslamicBook.fromRawJson(String str) => IslamicBook.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory IslamicBook.fromJson(Map<String, dynamic> json) => IslamicBook(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        filePath: json["file_path"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "file_path": filePath,
    };
}
