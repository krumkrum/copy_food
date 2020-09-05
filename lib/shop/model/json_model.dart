import 'dart:convert';

DataPost dataPostFromJson(String str) => DataPost.fromJson(json.decode(str));


class DataPost {
  DataPost({
    this.pops,
    this.combo,
    this.shrimp,
    this.grill,
  });

  List<Item> pops;
  List<Item> combo;
  List<Item> shrimp;
  List<Item> grill;

  factory DataPost.fromJson(Map<String, dynamic> json) => DataPost(
    pops: List<Item>.from(json["pops"].map((x) => Item.fromJson(x))),
    combo: List<Item>.from(json["combo"].map((x) => Item.fromJson(x))),
    shrimp: List<Item>.from(json["shrimp"].map((x) => Item.fromJson(x))),
    grill: List<Item>.from(json["grill"].map((x) => Item.fromJson(x))),
  );

}
class Item extends Product{
  Item({
    this.name,
    this.text,
    this.price,
    this.weight,
    this.pic,
  }) : super(name, price, text, weight, pic);

  String name;
  String text;
  int price;
  double weight;
  String pic;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    name: json["name"],
    text: json["text"],
    price: json["price"],
    weight: json["weight"].toDouble(),
    pic: json["pic"],
  );


}

class ShopModel {
  final String categoryName;
  final List<Product> products;
  double position = 0;

  ShopModel({this.categoryName, this.products});
}
class Product{

  String name;
  String text;
  int price;
  double weight;
  String pic;

  Product(this.name, this.price, this.text, this.weight, this.pic);
}
