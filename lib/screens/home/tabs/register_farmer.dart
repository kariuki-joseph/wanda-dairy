import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanda_dairy/screens/home/controller/register_farmer_controller.dart';
import 'package:wanda_dairy/widgets/custom_input.dart';
import 'package:wanda_dairy/widgets/primary_button.dart';
import 'package:wanda_dairy/widgets/secondary_button.dart';

class RegisterFarmer extends StatelessWidget {
  RegisterFarmer({super.key});
  final RegisterFarmerController _controller =
      Get.put(RegisterFarmerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Registered Farmers',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(
                      () => _controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : DataTable(
                              border: TableBorder.all(
                                color: Colors.black,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              columns: const [
                                DataColumn(label: Text("Name")),
                                DataColumn(label: Text("Email")),
                                DataColumn(label: Text("Phone")),
                              ],
                              rows: _controller.registeredFarmers.value
                                  .map(
                                    (farmer) => DataRow(
                                      cells: [
                                        DataCell(
                                          Text(
                                            farmer.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            farmer.email,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            farmer.phone,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SecondaryButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return buildRegisterBottomSheet(context, _controller);
                  },
                );
              },
              icon: const Icon(Icons.add_box_outlined),
              label: const Text("Register Farmer"),
            ),
          )
        ],
      ),
    );
  }

  Widget buildRegisterBottomSheet(
      BuildContext context, RegisterFarmerController controller) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return FractionallySizedBox(
      heightFactor: 0.7,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              "Register Farmer",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Obx(
                        () => CustomTextFormField(
                          labelText: "Farmer's Name",
                          hintText: "Enter Farmer Name",
                          initialValue: controller.name.value,
                          onChanged: (value) => controller.name.value = value,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () => CustomTextFormField(
                          labelText: "Farmer's Email",
                          hintText: "Enter Farmer Email",
                          initialValue: controller.email.value,
                          onChanged: (value) => controller.email.value = value,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () => CustomTextFormField(
                          labelText: "Farmer's Phone",
                          hintText: "Enter Farmer Phone",
                          initialValue: controller.phone.value,
                          onChanged: (value) => controller.phone.value = value,
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () => CustomTextFormField(
                          labelText: "Farmer's Password",
                          hintText: "Enter Password",
                          initialValue: controller.password.value,
                          onChanged: (value) =>
                              controller.password.value = value,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () => PrimaryButton(
                          onPressed: () async {
                            await controller.registerFarmer();
                            // clear form if registration is successful
                            if (controller.registerSuccess.value) {
                              formKey.currentState?.reset();
                              // reset register success
                              controller.registerSuccess.value = false;
                            }
                          },
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator()
                              : const Text("Save"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
