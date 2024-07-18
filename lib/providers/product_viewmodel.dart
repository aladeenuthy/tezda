import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product.dart';

class ProductViewmodel extends ChangeNotifier {
  List<Product> products = [];
  List<Product> favoriteProducts = [];
  List<String> favoritesCached = [];

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final _dio = Dio();
  final SharedPreferences prefs;
  String errorMessage = "";
  ProductViewmodel({
    required this.prefs,
  });
  Future<bool> fetchProducts() async {
    try {
      isLoading = true;
      final response = await _dio.get(
        'https://fakestoreapi.com/products/',
      );
      final List<Map<String, dynamic>> responseList =
          List<Map<String, dynamic>>.from(response.data);
      favoritesCached = prefs.getStringList("favorites") ?? [];
      products = responseList.map((productJSon) {
        final product = Product.fromJson(productJSon);
        if (favoritesCached.contains(product.id)) {
          favoriteProducts.add(product);
        }
        return product;
      }).toList();

      isLoading = false;
      return true;
    } catch (err, stack) {
      isLoading = false;
      errorMessage = "Check Your Network Connectivity";
      log(err.toString());
      log(stack.toString());
      return false;
    }
  }

  void toggleFavorites(Product product) {
    if (favoritesCached.contains(product.id)) {
      favoritesCached.remove(product.id);
      favoriteProducts.removeWhere((element) => element.id == product.id);
    } else {
      favoritesCached.add(product.id);
      favoriteProducts.insert(0, product);
    }
    prefs.setStringList("favorites", favoritesCached);
    notifyListeners();
  }

  bool isFavorite(String id) {
    return favoritesCached.contains(id);
  }

  List<Product> getProductByCategory(String category) {
    return products.where((product) => product.category == category).toList();
  }
}
