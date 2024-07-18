
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_viewmodel.dart';
import 'auth/auth_screen.dart';
import 'dashboard/dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      final authViewModel = context.read<AuthViewModel>();
      if (authViewModel.isUserLoggedIn) {
        Navigator.of(context).popAndPushNamed(DashBoard.routeName);
      } else {
        Navigator.of(context).popAndPushNamed(AuthScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircleAvatar(
          radius: 95,
          backgroundColor: Colors.white,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 90,
              child: Image.asset("assets/images/logo.png"),
            ),
          ]),
        ),
      ),
    );
  }
}
