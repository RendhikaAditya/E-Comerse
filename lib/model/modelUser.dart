// To parse this JSON data, do
//
//     final modelUser = modelUserFromJson(jsonString);

import 'dart:convert';

ModelUser modelUserFromJson(String str) => ModelUser.fromJson(json.decode(str));

String modelUserToJson(ModelUser data) => json.encode(data.toJson());

class ModelUser {
  int? value;
  String? message;
  String? fullname;
  String? email;
  String? phone;
  String? address;
  int? idUser;
  String? role;

  ModelUser({
    this.value,
    this.message,
    this.fullname,
    this.email,
    this.phone,
    this.address,
    this.idUser,
    this.role,
  });

  factory ModelUser.fromJson(Map<String, dynamic> json) => ModelUser(
    value: json["value"],
    message: json["message"],
    fullname: json["fullname"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    idUser: json["id_user"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
    "fullname": fullname,
    "email": email,
    "phone": phone,
    "address": address,
    "id_user": idUser,
    "role": role,
  };
}
