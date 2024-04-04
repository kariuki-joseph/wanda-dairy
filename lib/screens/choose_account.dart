import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wanda_dairy/enums/user_type.dart';
import 'package:wanda_dairy/routes/app_routes.dart';
import 'package:wanda_dairy/widgets/info_box.dart';

class ChooseAccount extends StatelessWidget {
  const ChooseAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text('Wanda Dairy',
                style: Theme.of(context).textTheme.displayMedium),
            const Spacer(
              flex: 1,
            ),
            Image.asset(
              "images/logo.png",
              fit: BoxFit.contain,
            ),
            const Spacer(
              flex: 1,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Continue as?',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InfoBox(
                      top: Image.asset(
                        "images/admin.png",
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                      bottom: const Text("Wanda Dairy"),
                      onTap: () {
                        Get.toNamed(
                          AppRoute.adminLogin,
                          arguments: UserType.dairy,
                        );
                      },
                    ),
                    InfoBox(
                      top: Image.asset(
                        "images/farmer.png",
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                      bottom: const Text("Farmer"),
                      onTap: () {
                        Get.toNamed(
                          AppRoute.farmerLogin,
                          arguments: UserType.farmer,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
