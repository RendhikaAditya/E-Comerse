// To parse this JSON data, do
//
//     final modelBase = modelBaseFromJson(jsonString);

import 'dart:convert';

ModelBase modelBaseFromJson(String str) => ModelBase.fromJson(json.decode(str));

String modelBaseToJson(ModelBase data) => json.encode(data.toJson());

class ModelBase {
  int? value;
  String? message;

  ModelBase({
    this.value,
    this.message,
  });

  factory ModelBase.fromJson(Map<String, dynamic> json) => ModelBase(
    value: json["value"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
  };
}
