import 'dart:convert';
import 'dart:io';

class Products {
  String nama = "";
  String price = "";
  String image = " ";
  String id = "";
  String desc = "";

  Products(
      {required this.nama,
      required this.price,
      required this.image,
      required this.id,
      required this.desc});

  factory Products.fromJson(Map<String, dynamic> map) {
    return Products(
        nama: map["nama"],
        price: map["price"],
        image: map["image"],
        id: map["id"],
        desc: map["desc"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "nama": nama,
      "price": price,
      "image": image,
      "id": id,
      "desc": desc
    };
  }

  @override
  String toString() {
    return 'Products{nama: $nama, price: $price, image: $image, id: $id, desc : $desc}';
  }
}

List<Products> productsFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Products>.from(data.map((item) => Products.fromJson(item)));
}

String productToJson(Products data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
