import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanda_dairy/screens/home/controller/profile_tab_controller.dart';
import 'package:wanda_dairy/widgets/primary_button.dart';

class ProfileTab extends StatelessWidget {
  final ProfileTabController controller = Get.put(ProfileTabController());

  ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Profile',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/profile.png'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Name: ",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Obx(() => Text(controller.savedUser.value.name)),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Email: ",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Obx(() => Text(controller.savedUser.value.email)),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Phone: ",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Obx(() => Text(controller.savedUser.value.phone)),
              ],
            ),
            const SizedBox(height: 20),
            Obx(
              () => PrimaryButton(
                onPressed: () {
                  controller.logout();
                },
                child: controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
