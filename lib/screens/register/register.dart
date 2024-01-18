import 'package:flutter/material.dart';
import 'package:wanda_dairy/themes/app_colors.dart';
import 'package:wanda_dairy/widgets/custom_input.dart';
import 'package:wanda_dairy/widgets/primary_button.dart';
import 'package:wanda_dairy/widgets/secondary_button.dart';
import 'package:wanda_dairy/widgets/vertical_space.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Create An Account',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpace(20),
                const CustomTextFormField(
                  labelText: "Company Name",
                  hintText: "Enter Company Name",
                ),
                const VerticalSpace(10.0),
                const CustomTextFormField(
                  labelText: "Company Email",
                  hintText: "Enter Company Email",
                  keyboardType: TextInputType.emailAddress,
                ),
                const VerticalSpace(10.0),
                const CustomTextFormField(
                  labelText: "Company Phone Number",
                  hintText: "Enter Company Phone Number",
                  keyboardType: TextInputType.phone,
                ),
                const VerticalSpace(10.0),
                const CustomTextFormField(
                  labelText: "Password",
                  hintText: "Enter Password",
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                const VerticalSpace(10.0),
                const CustomTextFormField(
                  labelText: "Confirm Password",
                  hintText: "Confirm Password",
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                const VerticalSpace(10.0),
                Center(
                  child: PrimaryButton(
                    onPressed: () {},
                    child: const Text("Register"),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {},
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
