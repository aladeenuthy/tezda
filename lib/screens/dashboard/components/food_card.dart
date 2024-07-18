import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import '../../../models/product.dart';
import '../../../utils/constants.dart';
import '../../../utils/string_utils.dart';
import '../../food_details/food_details_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(FoodDetailsScreen.routeName, arguments: product),
      child: Align(
        child: Container(
          height: 230,
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          width: 160,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  height: 200,
                  width: 160,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        StringUtils.truncate(product.name, 20),
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontSize: 13),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("\$${product.price}",
                          style: const TextStyle(
                              color: primaryColor, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            image:
                                CachedNetworkImageProvider(product.images[0]),
                            fit: BoxFit.cover)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
