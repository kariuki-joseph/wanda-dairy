import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wanda_dairy/screens/home/controller/milk_collection_controller.dart';
import 'package:wanda_dairy/screens/home/controller/register_farmer_controller.dart';
import 'package:wanda_dairy/widgets/custom_input.dart';
import 'package:wanda_dairy/widgets/info_box.dart';
import 'package:wanda_dairy/widgets/primary_button.dart';
import 'package:wanda_dairy/widgets/secondary_button.dart';
import 'package:wanda_dairy/widgets/my_btn_loader.dart';

class DairyHomeTab extends StatelessWidget {
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
        Center(
          child: Text(
            'Good Morning Wanda Dairy',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        const SizedBox(height: 30),
        // summary boxes
        Row(
          children: [
            Obx(
              () => InfoBox(
                top: Text(
                  milkCollectionController.litresCollectedToday.toString(),
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
        const SizedBox(height: 30),
        Text(
          "Today's Collection Summary",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Obx(
            () => DataTable(
              columns: const [
                DataColumn(
                  label: Text('Farmer Name'),
                ),
                DataColumn(
                  label: Text('Volume of Milk (Ltrs)'),
                ),
              ],
              rows: milkCollectionController.milkCollections
                  .map(
                    (milkCollection) => DataRow(
                      cells: [
                        DataCell(Text(milkCollection.farmerName)),
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
                          milkCollectionController.volumeOfMilk.value = value;
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
                      CustomTextFormField(
                        labelText: "Price per Litre",
                        hintText: "Price per",
                        controller:
                            milkCollectionController.pricePerLtrController,
                        onChanged: (value) => milkCollectionController
                            .pricePerLitre.value = value,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Price per litre is required";
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
                              : const Text("Save"),
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
                          farmerController.registeredFarmers[index].name,
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
}
