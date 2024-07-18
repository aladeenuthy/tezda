
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_viewmodel.dart';
import '../../utils/constants.dart';
import '../../utils/screens.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const routeName = "/auth-screen";

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(builder: (context, authVm, _) {
      return DefaultTabController(
        length: 2,
        child: AppScaffold(
          isLoading: authVm.isLoading,
          body: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 4.0),
                        blurRadius: 30.0,
                        color: blackColor.withOpacity(0.06),
                      ),
                    ],
                    color: whiteColor,
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(25)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          'assets/images/logo.png',
                        ),
                      ),
                      const TabBar(
                        indicatorColor: primaryColor,
                        labelColor: Colors.black,
                        tabs: [
                          Tab(text: "login"),
                          Tab(text: 'signup'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Expanded(
                flex: 4,
                child: TabBarView(
                  children: [LoginScreen(), SignupScreen()],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
