// To parse this JSON data, do
//
//     final modelCart = modelCartFromJson(jsonString);

import 'dart:convert';

ModelCart modelCartFromJson(String str) => ModelCart.fromJson(json.decode(str));

String modelCartToJson(ModelCart data) => json.encode(data.toJson());

class ModelCart {
  bool? isSuccess;
  String? message;
  List<Datum>? data;

  ModelCart({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory ModelCart.fromJson(Map<String, dynamic> json) => ModelCart(
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
  String? idChart;
  String? idUser;
  String? idProduct;
  String? quantity;
  String? user;
  String? name;
  String? description;
  String? price;
  String? stock;
  String? idCategory;
  String? foto;
  String? kategori;

  Datum({
    this.idChart,
    this.idUser,
    this.idProduct,
    this.quantity,
    this.user,
    this.name,
    this.description,
    this.price,
    this.stock,
    this.idCategory,
    this.foto,
    this.kategori,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idChart: json["id_chart"],
    idUser: json["id_user"],
    idProduct: json["id_product"],
    quantity: json["quantity"],
    user: json["User"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    stock: json["stock"],
    idCategory: json["id_category"],
    foto: json["foto"],
    kategori: json["kategori"],
  );

  Map<String, dynamic> toJson() => {
    "id_chart": idChart,
    "id_user": idUser,
    "id_product": idProduct,
    "quantity": quantity,
    "User": user,
    "name": name,
    "description": description,
    "price": price,
    "stock": stock,
    "id_category": idCategory,
    "foto": foto,
    "kategori": kategori,
  };
}
