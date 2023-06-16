import 'package:flutter/material.dart';
import 'shoe_model.dart';

class ListShoeModel extends ChangeNotifier {
  final List<Shoe> shoes;

  ListShoeModel({required this.shoes});

  factory ListShoeModel.fromJson(Map<String, dynamic> json) {
    List<Shoe> shoes = (json['shoes'] as List<dynamic>)
        .map((item) => Shoe.fromJson(item))
        .toList();

    return ListShoeModel(shoes: shoes);
  }
}
