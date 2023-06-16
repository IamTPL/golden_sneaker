import 'package:flutter/material.dart';
import 'shoe_model.dart';
import 'dart:collection';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartModel extends ChangeNotifier {
  final List<Shoe> _cartList = [];

  CartModel() {
    getCartListFromSharedPrefs().then((value) {
      _cartList.addAll(value);
      notifyListeners();
    });
  }

  //get data from LocalStorage
  static Future<List<Shoe>> getCartListFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final cartListJson = prefs.getString('cartListLocal');

    if (cartListJson != null) {
      final List<dynamic> decodedList = jsonDecode(cartListJson);
      final cartList = decodedList.map((item) => Shoe.fromJson(item)).toList();
      return cartList;
    }

    return [];
  }

  //set Data to LocalStorage
  Future<void> saveCartListToSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedList =
        jsonEncode(_cartList.map((shoe) => shoe.toJson()).toList());
    await prefs.setString('cartListLocal', encodedList);
  }

  UnmodifiableListView<Shoe> get cartList => UnmodifiableListView(_cartList);

  String totalPrice() {
    double sum =
        _cartList.fold(0.0, (sum, item) => sum + item.price * item.quantity);
    return sum.toStringAsFixed(2);
  }

  void add(Shoe shoe) {
    shoe.quantity = 1;
    _cartList.add(shoe);
    notifyListeners();
    saveCartListToSharedPrefs();
  }

  void decrease(int id) {
    int index = _cartList.indexWhere((element) => element.id == id);

    if (index != -1) {
      _cartList[index].quantity--;
      if (_cartList[index].quantity <= 0) {
        _cartList[index].quantity = 0;
        remove(_cartList[index]);
      }

      notifyListeners();
      saveCartListToSharedPrefs();
    }
  }

  void increase(int id) {
    int index = _cartList.indexWhere((element) => element.id == id);

    if (index != -1) {
      _cartList[index].quantity++;
      notifyListeners();
      saveCartListToSharedPrefs();
    }
  }

  void remove(shoe) {
    shoe.quantity = 0;
    _cartList.remove(shoe);
    notifyListeners();
    saveCartListToSharedPrefs();
  }
}
