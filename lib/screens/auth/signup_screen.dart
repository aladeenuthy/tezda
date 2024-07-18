
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_viewmodel.dart';
import '../../utils/constants.dart';
import '../../utils/services.dart';
import 'widgets/input_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  void signUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    final authViewmel = context.read<AuthViewModel>();
    await authViewmel.signup(_emailController.text.trim(),
        _passwordController.text.trim(), _nameController.text.trim());
    _emailController.clear();
    _passwordController.clear();
    _nameController.clear();
    setState(() {});
    showSnackBar("Sign Up Successfully", false);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const PageStorageKey<String>('signup'),
      child: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20),
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            InputField(
              labelText: "Full name",
              controller: _nameController,
              validator: (value) {
                if (value!.isEmpty || value.length < 5) {
                  return 'name is too short!';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            InputField(
              labelText: "Email address",
              keyBoardType: TextInputType.emailAddress,
              controller: _emailController,
              validator: (value) {
                if (value!.isEmpty || !value.contains('@')) {
                  return 'Invalid email!';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            InputField(
              labelText: "Password",
              controller: _passwordController,
              validator: (value) {
                if (value!.isEmpty || value.length < 5) {
                  return 'Password is too short!';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: signUp,
              child: const Text(
                "Sign up",
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ]),
        ),
      ),
    );
  }
}
