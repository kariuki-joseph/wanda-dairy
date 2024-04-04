import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanda_dairy/routes/app_routes.dart';
import 'package:wanda_dairy/screens/register/controller/register_controller.dart';
import 'package:wanda_dairy/themes/app_colors.dart';
import 'package:wanda_dairy/widgets/custom_input.dart';
import 'package:wanda_dairy/widgets/primary_button.dart';
import 'package:wanda_dairy/widgets/vertical_space.dart';

class RegisterAdmin extends StatefulWidget {
  const RegisterAdmin({super.key});

  @override
  State<RegisterAdmin> createState() => _RegisterAdminState();
}

class _RegisterAdminState extends State<RegisterAdmin> {
  final RegisterController _registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Admin Create Account',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset("images/admin.png", height: 150.0),
                ),
                const VerticalSpace(10.0),
                Center(
                  child: Text(
                    "Create Admin Account",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  labelText: "Company Name",
                  hintText: "Enter Company Name",
                  onChanged: (value) => _registerController.name.value = value,
                ),
                const VerticalSpace(10.0),
                CustomTextFormField(
                  labelText: "Company Email",
                  hintText: "Enter Company Email",
                  onChanged: (value) => _registerController.email.value = value,
                  keyboardType: TextInputType.emailAddress,
                ),
                const VerticalSpace(10.0),
                CustomTextFormField(
                  labelText: "Company Phone Number",
                  hintText: "Enter Company Phone Number",
                  onChanged: (value) => _registerController.phone.value = value,
                  keyboardType: TextInputType.phone,
                ),
                const VerticalSpace(10.0),
                CustomTextFormField(
                  labelText: "Password",
                  hintText: "Enter Password",
                  onChanged: (value) =>
                      _registerController.password.value = value,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                const VerticalSpace(10.0),
                CustomTextFormField(
                  labelText: "Confirm Password",
                  hintText: "Confirm Password",
                  onChanged: (value) =>
                      _registerController.confirmPassword.value = value,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                const VerticalSpace(16.0),
                Center(
                  child: Obx(
                    () => PrimaryButton(
                      onPressed: () {
                        _registerController.register();
                      },
                      child: _registerController.isLoading.value
                          ? const CircularProgressIndicator()
                          : Text(
                              "Register",
                              style: Get.theme.textTheme.bodyMedium,
                            ),
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Login',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: AppColors.primaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(AppRoute.adminLogin);
                                },
                            ),
                          ],
                        ),
                      ),
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
