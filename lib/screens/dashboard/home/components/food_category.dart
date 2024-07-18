import 'package:flutter/material.dart';

import '../../../../models/product.dart';
import '../../components/food_card.dart';

class ProductCategory extends StatelessWidget {
  final String categoryName;
  final List<Product> categoryProducts;
  const ProductCategory(
      {Key? key, required this.categoryName, required this.categoryProducts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double aspectRatio = screenWidth / 1.8 / 280;
    return GridView.builder(
            gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10,
              childAspectRatio: aspectRatio
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemCount: categoryProducts.length,
            itemBuilder: (context, index) {
              return ProductCard(
                    product: categoryProducts[index],
                  );
            },
          );
  }
}
