
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/device_helper.dart';
import '../../providers/auth_viewmodel.dart';
import '../../providers/cart_viewmodel.dart';
import '../../providers/product_viewmodel.dart';
import '../../utils/constants.dart';
import '../../utils/screens.dart';
import '../auth/auth_screen.dart';
import '../cart/cart_screen.dart';
import 'favorites_screen.dart';
import 'home/home_screen.dart';
import 'home/profile_screen.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);
  static const routeName = "/dashboard";

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  var _drawerOpen = false;

  Matrix4 _shadowTransform() {
    return Matrix4.identity()
      ..translate(180.2, 120.3)
      ..scale(0.7);
  }

  Matrix4 _mainScreenTransform() {
    return Matrix4.identity()
      ..translate(200.2, 100.3)
      ..scale(0.7);
  }

  late ProductViewmodel productViewmodel;
  @override
  void initState() {
    super.initState();
    productViewmodel = context.read<ProductViewmodel>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productViewmodel.fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _Drawer(),
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: DeviceHelper.screenHeight,
          width: DeviceHelper.screenWidth,
          transform: _drawerOpen ? _shadowTransform() : Matrix4.identity(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: shadowColor,
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: _drawerOpen ? _mainScreenTransform() : Matrix4.identity(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_drawerOpen ? 20 : 0),
            child:
                Consumer<ProductViewmodel>(builder: (context, viewmodel, __) {
              return AppScaffold(
                isLoading: viewmodel.isLoading,
                appBar: CustomAppBar(
                  isLoading: viewmodel.isLoading,
                  leading: IconButton(
                      onPressed: () {
                        setState(() {
                          _drawerOpen = !_drawerOpen;
                        });
                      },
                      icon: Image.asset('assets/images/menu.png')),
                  actions: [
                    Consumer<CartViewModel>(builder: (context, viewmodel, _) {
                      return IconButton(
                          onPressed: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (_, __, ___) =>
                                    const CartScreen()));
                          },
                          icon: Badge(
                            backgroundColor: primaryColor,
                            isLabelVisible: viewmodel.cartItems.isNotEmpty,
                            label: Text(viewmodel.cartItems.length.toString()),
                            child: Icon(Icons.shopping_cart_outlined,
                                color: Colors.black.withOpacity(0.7)),
                          ));
                    })
                  ],
                ),
                body: AbsorbPointer(
                  absorbing: _drawerOpen,
                  child: const HomeScreen(),
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Spacer(
              flex: 2,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(FavoritesScreen.routeName);
              },
              child: const _DrawerTile(
                title: "Favorites",
                icon: Icons.favorite,
              ),
            ),
            const Divider(color: whiteColor, endIndent: 180, thickness: 1),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.of(context).pushNamed(ProfileScreen.routeName);
              },
              child: const _DrawerTile(
                title: "Profile",
                icon: Icons.person,
              ),
            ),
            const Divider(color: whiteColor, endIndent: 180, thickness: 1),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                final authViewmodel = context.read<AuthViewModel>();
                authViewmodel.logout();

                Navigator.of(context).popAndPushNamed(AuthScreen.routeName);
              },
              child: const _DrawerTile(
                title: "Logout",
                icon: Icons.logout,
              ),
            ),
            const Divider(
              color: whiteColor,
              endIndent: 180,
              thickness: 1,
            ),
            const Spacer(
              flex: 3,
            )
          ]),
        ),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  const _DrawerTile({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: whiteColor,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(title,
            style: const TextStyle(
                color: whiteColor, fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
