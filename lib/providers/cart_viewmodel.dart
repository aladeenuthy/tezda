
import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../models/product.dart';

class CartViewModel extends ChangeNotifier {
  List<CartItem> cartItems = [];

  // Add item to the cart
  void addItemToCart(Product product, int quantity) {
    for (var item in cartItems) {
      if (item.product.id == product.id) {
        item.quantity  = item.quantity + quantity;
        notifyListeners();
        return;
      }
    }

    cartItems.add(CartItem(product: product, quantity: quantity));
    notifyListeners();
  }

  // Remove item from the cart
  void removeItemFromCart(CartItem cartItem) {
    cartItems.remove(cartItem);
    notifyListeners();
  }

  void clearCart() {
    cartItems = [];
    notifyListeners();
  }

  // Get total price of items in the cart
  int get getTotalPrice {
    int total = 0;
    for (var item in cartItems) {
      total += item.product.price * item.quantity;
    }
    return total;
  }
}
