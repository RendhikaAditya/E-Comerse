// To parse this JSON data, do
//
//     final modelOrder = modelOrderFromJson(jsonString);

import 'dart:convert';

ModelOrder modelOrderFromJson(String str) => ModelOrder.fromJson(json.decode(str));

String modelOrderToJson(ModelOrder data) => json.encode(data.toJson());

class ModelOrder {
  bool? isSuccess;
  String? message;
  List<Datum>? data;

  ModelOrder({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory ModelOrder.fromJson(Map<String, dynamic> json) => ModelOrder(
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
  int? idOrder;
  int? idUser;
  String? totalAmount;
  String? status;
  List<Detail>? details;

  Datum({
    this.idOrder,
    this.idUser,
    this.totalAmount,
    this.status,
    this.details,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idOrder: json["id_order"],
    idUser: json["id_user"],
    totalAmount: json["total_amount"],
    status: json["status"],
    details: json["details"] == null ? [] : List<Detail>.from(json["details"]!.map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id_order": idOrder,
    "id_user": idUser,
    "total_amount": totalAmount,
    "status": status,
    "details": details == null ? [] : List<dynamic>.from(details!.map((x) => x.toJson())),
  };
}

class Detail {
  int? idOrderDetail;
  int? idOrder;
  int? idProduct;
  int? quantity;
  String? price;
  String? name;
  String? description;
  int? stock;
  int? idCategory;
  String? foto;
  String? category;

  Detail({
    this.idOrderDetail,
    this.idOrder,
    this.idProduct,
    this.quantity,
    this.price,
    this.name,
    this.description,
    this.stock,
    this.idCategory,
    this.foto,
    this.category,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    idOrderDetail: json["id_order_detail"],
    idOrder: json["id_order"],
    idProduct: json["id_product"],
    quantity: json["quantity"],
    price: json["price"],
    name: json["name"],
    description: json["description"],
    stock: json["stock"],
    idCategory: json["id_category"],
    foto: json["foto"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "id_order_detail": idOrderDetail,
    "id_order": idOrder,
    "id_product": idProduct,
    "quantity": quantity,
    "price": price,
    "name": name,
    "description": description,
    "stock": stock,
    "id_category": idCategory,
    "foto": foto,
    "category": category,
  };
}
