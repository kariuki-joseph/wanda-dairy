import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanda_dairy/routes/app_routes.dart';
import 'package:wanda_dairy/screens/login/controller/login_controller.dart';
import 'package:wanda_dairy/themes/app_colors.dart';
import 'package:wanda_dairy/widgets/custom_input.dart';
import 'package:wanda_dairy/widgets/primary_button.dart';
import 'package:wanda_dairy/widgets/vertical_space.dart';

class FarmerLogin extends StatefulWidget {
  const FarmerLogin({super.key});

  @override
  State<FarmerLogin> createState() => _FarmerLoginState();
}

class _FarmerLoginState extends State<FarmerLogin> {
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Farmer Login',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "images/farmer.png",
                  fit: BoxFit.contain,
                  colorBlendMode: BlendMode.modulate,
                ),
                Center(
                  child: Text('Farmer Login',
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                const VerticalSpace(20.0),
                Form(
                  key: _loginController.formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: _loginController.emailController,
                        labelText: "Email",
                        hintText: "Enter Email",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          }
                          if (!value.contains("@")) {
                            return "Invalid email address";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const VerticalSpace(10.0),
                      CustomTextFormField(
                        controller: _loginController.passwordController,
                        labelText: "Password",
                        hintText: "Enter Password",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
                const VerticalSpace(10.0),
                Center(
                  child: Obx(
                    () => PrimaryButton(
                      onPressed: () {
                        // call the login controller
                        _loginController.signIn();
                      },
                      child: _loginController.isLoading.value
                          ? const CircularProgressIndicator()
                          : const Text("Login"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
