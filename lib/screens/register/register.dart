import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanda_dairy/screens/register/controller/register_controller.dart';
import 'package:wanda_dairy/themes/app_colors.dart';
import 'package:wanda_dairy/widgets/custom_input.dart';
import 'package:wanda_dairy/widgets/primary_button.dart';
import 'package:wanda_dairy/widgets/vertical_space.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final RegisterController _registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Create an Account',
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
                const VerticalSpace(10.0),
                Center(
                  child: Obx(
                    () => PrimaryButton(
                      onPressed: () {
                        _registerController.register();
                      },
                      child: _registerController.isLoading.value
                          ? const CircularProgressIndicator()
                          : const Text("Register"),
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
                      child: Text(
                        "Already have an account? Login",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppColors.primaryColor),
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
