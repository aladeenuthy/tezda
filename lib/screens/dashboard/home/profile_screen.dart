import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';
import '../../../providers/auth_viewmodel.dart';
import '../../../utils/constants.dart';
import '../../../utils/screens.dart';
import '../../../utils/services.dart';
import '../../../utils/validators.dart';
import '../../auth/widgets/input_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const routeName = "/profile-screen";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;
  late AuthViewModel authViewModel;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _nameController;
  File? file;
  @override
  void initState() {
    super.initState();
    authViewModel = context.read<AuthViewModel>();
    user = authViewModel.getUser();
    _emailController = TextEditingController(text: user!.email);
    _nameController = TextEditingController(text: user!.name);
  }

  void pickProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage == null) return;
    file = File(pickedImage.path);
    setState(() {});
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(builder: (context, authVm, _) {
      return AppScaffold(
        isLoading: authVm.isLoading,
        appBar: CustomAppBar(
          isLoading: authVm.isLoading,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: blackColor,
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        backgroundColor: primaryColor,
                        backgroundImage:
                            (user!.profilePicture != null || file != null)
                                ? FileImage(file != null
                                    ? file!
                                    : File(user!.profilePicture!))
                                : null,
                        radius: 50,
                        child: (user!.profilePicture == null && file == null)
                            ? const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 50,
                              )
                            : null,
                      ),
                      GestureDetector(
                          onTap: () {
                            pickProfileImage();
                          },
                          child: const Icon(Icons.edit))
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  InputField(
                    initialValue: user!.email,
                    labelText: "Email address",
                    keyBoardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: Validator.emailValidator,
                  ),
                  const SizedBox(height: 10),
                  InputField(
                    initialValue: user!.name,
                    labelText: "Full name",
                    controller: _nameController,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 5) {
                        return 'name is too short!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      await authViewModel.updateUser(
                          _emailController.text.trim(),
                          _nameController.text.trim(),
                          file?.path);
                      showSnackBar("Profile Updated Successfully", false);
                    },
                    child: const Text(
                      "Update",
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
