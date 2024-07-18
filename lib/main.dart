
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/theme.dart';
import 'helpers/key_helper.dart';
import 'models/product.dart';
import 'providers/viewmodels.dart';
import 'screens/auth/auth_screen.dart';
import 'screens/dashboard/dashboard.dart';
import 'screens/dashboard/favorites_screen.dart';
import 'screens/dashboard/home/profile_screen.dart';
import 'screens/food_details/food_details_screen.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    prefs: prefs,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  const MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductViewmodel>(
          create: (_) => ProductViewmodel(prefs: prefs),
        ),
        ChangeNotifierProvider<AuthViewModel>(
          create: (_) => AuthViewModel(prefs: prefs),
        ),
        ChangeNotifierProvider<CartViewModel>(
          create: (_) => CartViewModel(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: KeyHelper.appNavKey,
        scaffoldMessengerKey: KeyHelper.scafKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme(),
        onGenerateRoute: (settings) {
          if (settings.name == FoodDetailsScreen.routeName) {
            final Product product = settings.arguments as Product;
            return PageRouteBuilder(
                pageBuilder: (_, __, ___) => FoodDetailsScreen(
                      product: product,
                    ));
          } else if (settings.name == AuthScreen.routeName) {
            return PageRouteBuilder(
                pageBuilder: (_, __, ___) => const AuthScreen());
          } else if (settings.name == DashBoard.routeName) {
            return PageRouteBuilder(
                pageBuilder: (_, __, ___) => const DashBoard());
          }else if (settings.name == FavoritesScreen.routeName) {
            return PageRouteBuilder(
                pageBuilder: (_, __, ___) => const FavoritesScreen());
          }
          else if (settings.name == ProfileScreen.routeName) {
            return PageRouteBuilder(
                pageBuilder: (_, __, ___) => const ProfileScreen());
          }
          return PageRouteBuilder(
              pageBuilder: (_, __, ___) => const SplashScreen());
        },
      ),
    );
  }
}
