import 'package:flutter/material.dart';

class ProductClass {
  String productname = '';
  int price;
  int quantity;
  String description = '';
  Image image;
  ProductClass(
      {required this.productname,
      required this.price,
      required this.quantity,
      required this.description,
      required this.image});
}
