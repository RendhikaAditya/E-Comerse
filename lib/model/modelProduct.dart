// To parse this JSON data, do
//
//     final modelProduct = modelProductFromJson(jsonString);

import 'dart:convert';

ModelProduct modelProductFromJson(String str) => ModelProduct.fromJson(json.decode(str));

String modelProductToJson(ModelProduct data) => json.encode(data.toJson());

class ModelProduct {
  bool? isSuccess;
  String? message;
  List<Datum>? data;

  ModelProduct({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory ModelProduct.fromJson(Map<String, dynamic> json) => ModelProduct(
    isSuccess: json["isSuccess"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? idProduct;
  String? name;
  String? description;
  String? price;
  String? stock;
  String? idCategory;
  String? foto;
  String? kategori;

  Datum({
    this.idProduct,
    this.name,
    this.description,
    this.price,
    this.stock,
    this.idCategory,
    this.foto,
    this.kategori,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idProduct: json["id_product"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    stock: json["stock"],
    idCategory: json["id_category"],
    foto: json["foto"],
    kategori: json["kategori"],
  );

  Map<String, dynamic> toJson() => {
    "id_product": idProduct,
    "name": name,
    "description": description,
    "price": price,
    "stock": stock,
    "id_category": idCategory,
    "foto": foto,
    "kategori": kategori,
  };
}
