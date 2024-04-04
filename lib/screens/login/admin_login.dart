import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wanda_dairy/routes/app_routes.dart';
import 'package:wanda_dairy/screens/login/controller/login_controller.dart';
import 'package:wanda_dairy/themes/app_colors.dart';
import 'package:wanda_dairy/widgets/custom_input.dart';
import 'package:wanda_dairy/widgets/primary_button.dart';
import 'package:wanda_dairy/widgets/vertical_space.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Admin Login',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Image.asset("images/admin.png", fit: BoxFit.contain),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text('Admin Login',
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                const VerticalSpace(20.0),
                Form(
                  key: _loginController.formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: _loginController.emailController,
                        labelText: "Company Email",
                        hintText: "Enter Company Email",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Company Email is required";
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
                const VerticalSpace(16.0),
                Center(
                  child: Obx(
                    () => PrimaryButton(
                      onPressed: () {
                        // call the login controller
                        _loginController.signIn();
                      },
                      child: _loginController.isLoading.value
                          ? const CircularProgressIndicator()
                          : const Text("Login", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Don't have an account? ",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextSpan(
                        text: "Register",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppColors.primaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(AppRoute.registerAdmin);
                          },
                      ),
                    ]),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
