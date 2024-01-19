import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanda_dairy/routes/app_routs.dart';
import 'package:wanda_dairy/screens/login/controller/login_controller.dart';
import 'package:wanda_dairy/themes/app_colors.dart';
import 'package:wanda_dairy/widgets/custom_input.dart';
import 'package:wanda_dairy/widgets/primary_button.dart';
import 'package:wanda_dairy/widgets/vertical_space.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Login to your Account',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  labelText: "Company Email",
                  hintText: "Enter Company Email",
                  onChanged: (value) => _loginController.email.value = value,
                  keyboardType: TextInputType.emailAddress,
                ),
                const VerticalSpace(10.0),
                CustomTextFormField(
                  labelText: "Password",
                  hintText: "Enter Password",
                  onChanged: (value) => _loginController.password.value = value,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
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
                // check if user is farmer and hide the widget below
                // ...
                // Hide create account for farmers
                Center(
                  child: (Get.arguments == null || Get.arguments == "dairy")
                      ? GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoute.register);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Don't have an account? Register",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: AppColors.primaryColor),
                            ),
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
