import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_viewmodel.dart';
import '../../utils/constants.dart';
import '../../utils/services.dart';
import '../dashboard/dashboard.dart';
import 'widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      showSnackBar(
        "Please fill all fields",
      );
      return;
    }
    FocusScope.of(context).unfocus();
    final authViewmel = context.read<AuthViewModel>();
    final isSuccessful = await authViewmel.login(
        _emailController.text.trim(), _passwordController.text.trim());
    if (!isSuccessful) {
      showSnackBar(
        "Invalid email or password",
      );
    } else {
      if (context.mounted) {
        Navigator.of(context).popAndPushNamed(DashBoard.routeName);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          InputField(
            labelText: "Email address",
            controller: _emailController,
            validator: (value) {
              if (value!.isEmpty || !value.contains('@')) {
                return 'Invalid email!';
              }
              return null;
            },
            keyBoardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 10),
          InputField(
            labelText: "Password",
            controller: _passwordController,
          ),
          const SizedBox(height: 20),
         
          ElevatedButton(
            onPressed: login,
            child: const Text(
              "Login",
              style: TextStyle(
                color: whiteColor,
                fontSize: 18,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
