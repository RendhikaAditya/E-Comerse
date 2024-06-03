// To parse this JSON data, do
//
//     final modelFavorite = modelFavoriteFromJson(jsonString);

import 'dart:convert';

ModelFavorite modelFavoriteFromJson(String str) => ModelFavorite.fromJson(json.decode(str));

String modelFavoriteToJson(ModelFavorite data) => json.encode(data.toJson());

class ModelFavorite {
  bool? isSuccess;
  String? message;
  List<DatumF>? data;

  ModelFavorite({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory ModelFavorite.fromJson(Map<String, dynamic> json) => ModelFavorite(
    isSuccess: json["isSuccess"],
    message: json["message"],
    data: json["data"] == null ? [] : List<DatumF>.from(json["data"]!.map((x) => DatumF.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DatumF {
  String? idMyfavorite;
  String? idUser;
  String? idProduct;
  String? user;
  String? name;
  String? description;
  String? price;
  String? stock;
  String? idCategory;
  String? foto;

  DatumF({
    this.idMyfavorite,
    this.idUser,
    this.idProduct,
    this.user,
    this.name,
    this.description,
    this.price,
    this.stock,
    this.idCategory,
    this.foto,
  });

  factory DatumF.fromJson(Map<String, dynamic> json) => DatumF(
    idMyfavorite: json["id_myfavorite"],
    idUser: json["id_user"],
    idProduct: json["id_product"],
    user: json["User"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    stock: json["stock"],
    idCategory: json["id_category"],
    foto: json["foto"],
  );

  Map<String, dynamic> toJson() => {
    "id_myfavorite": idMyfavorite,
    "id_user": idUser,
    "id_product": idProduct,
    "User": user,
    "name": name,
    "description": description,
    "price": price,
    "stock": stock,
    "id_category": idCategory,
    "foto": foto,
  };
}
