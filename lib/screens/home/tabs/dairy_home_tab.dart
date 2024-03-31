import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wanda_dairy/screens/home/controller/milk_collection_controller.dart';
import 'package:wanda_dairy/screens/home/controller/register_farmer_controller.dart';
import 'package:wanda_dairy/screens/login/controller/login_controller.dart';
import 'package:wanda_dairy/widgets/custom_input.dart';
import 'package:wanda_dairy/widgets/info_box.dart';
import 'package:wanda_dairy/widgets/primary_button.dart';
import 'package:wanda_dairy/widgets/secondary_button.dart';
import 'package:wanda_dairy/widgets/my_btn_loader.dart';

class DairyHomeTab extends StatelessWidget {
  final LoginController loginControler = Get.put(LoginController());
  final RegisterFarmerController farmerController =
      Get.put(RegisterFarmerController());
  final MilkCollectionController milkCollectionController =
      Get.put(MilkCollectionController());

  DairyHomeTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Good ${getTimeOfDay()}, ${loginControler.loggedInuser.value?.name.split(" ")[0]}",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 30),
        Text(
          "Welcome to your Dashboard! ",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        // summary boxes
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Obx(
              () => InfoBox(
                top: Text(
                  milkCollectionController.dailyCollectedLitres.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                bottom: Text(
                  "Litres Collected",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {},
              ),
            ),
            Obx(
              () => InfoBox(
                top: Text(
                  farmerController.registeredFarmers.length.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                bottom: Text(
                  "Farmers",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
        // orders
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Today's Price Per Litre",
                  style: Theme.of(context).textTheme.bodyLarge),
              Obx(
                () => InkWell(
                  onTap: () {
                    openEditPriceDialog();
                  },
                  child: Text(
                    "Ksh. ${milkCollectionController.pricePerLitre.value.toString()}",
                    style: Get.theme.textTheme.bodyLarge
                        ?.copyWith(decoration: TextDecoration.underline),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Today's Collection Summary",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Obx(
            () => SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                border: TableBorder.all(
                  color: Colors.black,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                columnSpacing: 5,
                clipBehavior: Clip.antiAlias,
                headingTextStyle: TextStyle(
                  color: Get.theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                dataTextStyle: TextStyle(
                    color: Get.theme.colorScheme.onSurface, fontSize: 12),
                headingRowColor: MaterialStateProperty.all(
                  Get.theme.colorScheme.surfaceVariant,
                ),
                columns: const [
                  DataColumn(label: Text("Farmer Name")),
                  DataColumn(label: Text("Phone")),
                  DataColumn(label: Text("Vol of Milk(Ltrs)")),
                ],
                rows: milkCollectionController.milkCollections
                    .map(
                      (milkCollection) => DataRow(
                        cells: [
                          DataCell(Text(milkCollection.farmerName)),
                          DataCell(Text(milkCollection.phone)),
                          DataCell(
                            Text(milkCollection.volumeInLitres.toString()),
                          ),
                        ],
                      ),
                    )
                    .toList(),
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
                  return buildCollectMilkBottomSheet(context);
                },
              );
            },
            icon: const Icon(Icons.add_box_outlined),
            label: const Text("Collect Milk"),
          ),
        ),
      ],
    );
  }

  Widget buildCollectMilkBottomSheet(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.7,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              "Collect Milk",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: milkCollectionController.formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      TextFormField(
                        readOnly: true,
                        controller: milkCollectionController.nameController,
                        decoration: InputDecoration(
                          labelText: "Farmer's Name",
                          hintText: "Enter Farmer's Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Farmer's Name is required";
                          }
                          return null;
                        },
                        onTap: () {
                          openSelectFarmerDialog(context);
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: milkCollectionController.dateController,
                        decoration: CustomTextFormField.myInputDecoration(
                          labelText: "Date of Delivery",
                          hintText: "10/01/2028",
                        ),
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Date of Delivery is required";
                          }
                          return null;
                        },
                        onTap: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(
                              DateTime.now().year + 1,
                            ),
                          );
                          if (selectedDate != null) {
                            milkCollectionController.dateController.text =
                                DateFormat("dd/MM/yyyy").format(selectedDate);
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        labelText: "Volume of Milk",
                        hintText: "Volume of Milk (Litres)",
                        controller:
                            milkCollectionController.milkVolumeController,
                        onChanged: (value) {
                          milkCollectionController.dailyMilkVol.value =
                              double.parse(value);
                        },
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Volume of Milk is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        enabled: false,
                        controller: milkCollectionController.earningsController,
                        decoration: InputDecoration(
                          labelText: "Total Due",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () => PrimaryButton(
                          onPressed: () {
                            // save milk collection
                            milkCollectionController.saveMilkCollection();
                          },
                          child: milkCollectionController.isLoading.value
                              ? const MyBtnLoader()
                              : const Text("Save Collection"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> openSelectFarmerDialog(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.7,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  "Select Farmer",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: farmerController.registeredFarmers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          "${farmerController.registeredFarmers[index].phone} - ${farmerController.registeredFarmers[index].name}",
                        ),
                        onTap: () {
                          // set this as the selected Farmer
                          milkCollectionController.selectedFarmer.value =
                              farmerController.registeredFarmers[index];
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void openEditPriceDialog() {
    // open a centered dialog with textFormField and a submit button
    milkCollectionController.pricePerLtrController.text =
        milkCollectionController.pricePerLitre.value.toString();
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Update Price Per Litre",
            style: Get.theme.textTheme.titleMedium,
          ),
          content: Form(
            key: milkCollectionController.updatePriceFormKey,
            child: TextFormField(
              controller: milkCollectionController.pricePerLtrController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                hintText: "Price Per Litre",
                labelText: "Price Per Litre",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Price per litre is required";
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            ),
            Obx(
              () => TextButton(
                onPressed: () async {
                  await milkCollectionController.updatePricePerLitre();
                  Navigator.pop(context);
                },
                child: milkCollectionController.isUpdatingMilkPrice.value
                    ? const CircularProgressIndicator()
                    : const Text("Update"),
              ),
            ),
          ],
        );
      },
    );
  }

  String getTimeOfDay() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Morning";
    }
    if (hour < 17) {
      return "Afternoon";
    }
    return "Evening";
  }
}
