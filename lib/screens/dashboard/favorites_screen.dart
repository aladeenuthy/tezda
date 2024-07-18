import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/product_viewmodel.dart';
import '../../utils/constants.dart';
import 'components/food_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({
    Key? key,
  }) : super(key: key);
  static const routeName = "/favorites-screen";
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double aspectRatio = screenWidth / 1.8 / 280;
    return Consumer<ProductViewmodel>(builder: (context, productVm, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Favorites",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: blackColor,
              )),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10,
              childAspectRatio: aspectRatio),
          padding: const EdgeInsets.symmetric(vertical: 40),
          itemCount: productVm.favoriteProducts.length,
          itemBuilder: (context, index) {
            return ProductCard(
              product: productVm.favoriteProducts[index],
            );
          },
        ),
      );
    });
  }
}
