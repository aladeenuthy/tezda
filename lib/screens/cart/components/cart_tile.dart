import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/cart_item.dart';
import '../../../providers/cart_viewmodel.dart';
import '../../../utils/constants.dart';
import '../../food_details/food_details_screen.dart';

class CartTile extends StatelessWidget {
  final bool dismiss;
  final CartItem cartItem;
  const CartTile({Key? key, required this.cartItem, required this.dismiss})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(FoodDetailsScreen.routeName,
            arguments: cartItem.product);
      },
      child: Dismissible(
        onDismissed: (dir) {
          context.read<CartViewModel>().removeItemFromCart(cartItem);
        },
        direction:
            dismiss ? DismissDirection.endToStart : DismissDirection.none,
        key: ValueKey(cartItem.product.id.toString() + cartItem.product.name),
        background: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(20)),
            alignment: Alignment.centerRight,
            child: const Icon(
              Icons.remove,
              color: Colors.white,
            )),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: ListTile(
            leading: CachedNetworkImage(
              imageUrl: cartItem.product.images[0],
              height: 50,
              width: 50,
            ),
            title: Text(cartItem.product.name),
            subtitle: Text(
              "\$${cartItem.product.price}",
              style: const TextStyle(color: primaryColor, fontSize: 15),
            ),
            trailing: Text("x${cartItem.quantity}"),
          ),
        ),
      ),
    );
  }
}
