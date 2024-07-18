

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/cart_item.dart';
import '../../providers/cart_viewmodel.dart';
import 'components/cart_tile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(builder: (context, viewmodel, _) {
      return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new),
              color: Colors.black,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    viewmodel.clearCart();
                  },
                  icon: const Icon(
                    Icons.cancel_outlined,
                    color: Colors.black,
                  ))
            ],
          ),
          body: viewmodel.cartItems.isEmpty
              ? SizedBox.expand(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/no_orders.png'),
                      const Text(
                        "Cart empty",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      CartSummary(
                        cartItems: viewmodel.cartItems,
                        total: viewmodel.getTotalPrice,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Expanded(
                          child: ListView.builder(
                        itemBuilder: (_, index) => CartTile(
                          cartItem: viewmodel.cartItems[index],
                          dismiss: true,
                        ),
                        itemCount: viewmodel.cartItems.length,
                      ))
                    ],
                  ),
                ));
    });
  }
}

class CartSummary extends StatelessWidget {
  final List<CartItem> cartItems;
  final int total;
  const CartSummary({Key? key, required this.cartItems, required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      width: double.infinity,
      child: Row(children: [
        const Text("Total"),
        const Spacer(),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                minimumSize: const Size(0, 0)),
            onPressed: () {},
            child: Text("\$$total")),
        const SizedBox(width: 10),
        TextButton(
          onPressed: () {
            // List<Map<String, dynamic>> cartItemsJson = cartItems
            //     .map((cartSnapshot) => cartSnapshot.data().toJson())
            //     .toList();
            // CartHelper.makePayment(total, cartItemsJson);
          },
          child: const Text("Order now"),
        )
      ]),
    );
  }
}
