
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/device_helper.dart';
import '../../../providers/product_viewmodel.dart';
import '../../../utils/constants.dart';
import '../../../utils/services.dart';
import 'components/food_category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String text = '';
  Matrix4 initial() {
    return Matrix4.identity()..translate(-(DeviceHelper.screenWidth), 60.0);
  }

  Matrix4 bodyOpen() {
    return Matrix4.identity()..translate(0.0, 60.0);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewmodel>(builder: (context, viewmodel, _) {
      return DefaultTabController(
        length: 4,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 200,
                child: Text("Discover, Shop, Enjoy",
                    style: Theme.of(context).textTheme.headlineLarge),
              ),
              const SizedBox(
                height: 10,
              ),
              TabBar(
                  isScrollable: true,
                  labelColor: Colors.black,
                  indicatorColor: primaryColor,
                  tabs: categories
                      .map((category) => Tab(
                            text: capitalize(category),
                          ))
                      .toList()),
              Expanded(
                  child: TabBarView(
                children: categories
                    .map((category) => ProductCategory(
                          categoryName: category,
                          categoryProducts:
                              viewmodel.getProductByCategory(category),
                        ))
                    .toList(),
              ))
            ]),
          ),
        ),
      );
    });
  }
}
