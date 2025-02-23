import 'dart:convert';

class DefaultResponse {
  bool? success;
  int? code;
  String? message;

  DefaultResponse({
    this.success,
    this.code,
    this.message,
  });

  DefaultResponse copyWith({
    bool? success,
    int? code,
    String? message,
  }) =>
      DefaultResponse(
        success: success ?? this.success,
        code: code ?? this.code,
        message: message ?? this.message,
      );

  factory DefaultResponse.fromRawJson(String str) =>
      DefaultResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DefaultResponse.fromJson(Map<String, dynamic> json) =>
      DefaultResponse(
        success: json["status"],
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": success,
        "code": code,
        "message": message,
      };
}
