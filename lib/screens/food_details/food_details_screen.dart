import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/product.dart';
import '../../providers/cart_viewmodel.dart';
import '../../providers/product_viewmodel.dart';
import '../../utils/constants.dart';
import '../../utils/screens.dart';
import '../../utils/services.dart';
import 'components/section.dart';

class FoodDetailsScreen extends StatefulWidget {
  final Product product;
  const FoodDetailsScreen({Key? key, required this.product}) : super(key: key);
  static const routeName = "/food-details";

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final pageController = PageController();
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewmodel>(builder: (context, productVm, _) {
      return Consumer<CartViewModel>(builder: (context, cartVm, _) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: blackColor,
                )),
            actions: [
              IconButton(
                  onPressed: () {
                    productVm.toggleFavorites(widget.product);
                  },
                  icon: Icon(
                    productVm.isFavorite(widget.product.id)
                        ? Icons.favorite
                        : Icons.favorite_outline,
                    color: primaryColor,
                  ))
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppAnimatedColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 180,
                      child: PageView.builder(
                          controller: pageController,
                          itemCount: widget.product.images.length,
                          itemBuilder: (_, index) => CachedNetworkImage(
                              imageUrl: widget.product.images[index])),
                    ),
                    Center(
                      child: SizedBox(
                        height: 25,
                        child: SmoothPageIndicator(
                            controller: pageController, // PageController
                            count: widget.product.images.length,
                            effect: const JumpingDotEffect(
                              activeDotColor: primaryColor,
                              dotWidth: 15,
                              dotHeight: 10,
                            ), // your preferred effect
                            onDotClicked: (index) {}),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Text(
                      widget.product.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 28),
                    )),
                    Center(
                      child: Text("\$${widget.product.price}",
                          style: const TextStyle(
                              fontSize: 20,
                              color: primaryColor,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RawMaterialButton(
                            splashColor: primaryColor,
                            onPressed: () {
                              if (quantity == 1) {
                                return;
                              }
                              setState(() {
                                quantity -= 1;
                              });
                            },
                            padding: const EdgeInsets.all(15),
                            shape: const CircleBorder(
                                side:
                                    BorderSide(color: primaryColor, width: 2)),
                            child: const Icon(
                              Icons.remove,
                              size: 25,
                              color: primaryColor,
                            )),
                        Text(
                          quantity.toString(),
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        RawMaterialButton(
                            splashColor: primaryColor,
                            onPressed: () {
                              setState(() {
                                quantity += 1;
                              });
                            },
                            padding: const EdgeInsets.all(15),
                            shape: const CircleBorder(
                                side:
                                    BorderSide(color: primaryColor, width: 2)),
                            child: const Icon(
                              Icons.add,
                              size: 25,
                              color: primaryColor,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(widget.product.description,
                        style: const TextStyle(
                            fontSize: 16,
                            color: greyColor,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 20,
                    ),
                    const Section(
                      title: 'Delivery info',
                      body:
                          'Delivered between Monday and Thursday from 8 Am to 11 Pm',
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        cartVm.addItemToCart(widget.product, quantity);
                        showSnackBar("Item added to cart", false);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          minimumSize: const Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                      child: const Text(
                        "Add to cart",
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ]),
            ),
          ),
        );
      });
    });
  }
}
