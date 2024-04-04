// wanda dairy payments
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wanda_dairy/screens/home/controller/payments_controller.dart';
import 'package:wanda_dairy/widgets/primary_button.dart';

class PaymentsTab extends StatelessWidget {
  PaymentsTab({super.key});
  final PaymentsController paymentsController = Get.put(PaymentsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text('Payment Details', style: Get.theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            Text(
              'Manage Farmer Payments',
              style: Get.theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
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
                    color: Get.theme.colorScheme.onSurface,
                    fontSize: 12,
                    overflow: TextOverflow.clip),
                headingRowColor: MaterialStateProperty.all(
                  Get.theme.colorScheme.surfaceVariant,
                ),
                columns: const [
                  DataColumn(label: Text("Farmer Name")),
                  DataColumn(label: Text("Phone")), // New column
                  DataColumn(label: Text("Total Amt.")),
                  DataColumn(label: Text("Due Amt.")),
                  DataColumn(label: Text("Action")),
                ],
                rows: List.generate(
                    paymentsController.milkCollections.value.length, (index) {
                  final collection =
                      paymentsController.milkCollections.value.toList()[index];

                  return DataRow(
                    cells: [
                      DataCell(Text(collection.farmerName)),
                      DataCell(Text(collection.phone)), // New cell
                      DataCell(
                        Obx(
                          () => Text(
                            NumberFormat("#,##0.00").format(paymentsController
                                    .totalAmt.value[collection.farmerId] ??
                                0),
                          ),
                        ),
                      ),
                      DataCell(
                        Obx(
                          () => Text(
                            NumberFormat("#,##0.00").format(double.parse(
                                paymentsController
                                        .amtDue.value[collection.farmerId]
                                        ?.toString() ??
                                    "0")),
                          ),
                        ),
                      ),
                      DataCell(
                        Obx(
                          () => PrimaryButton(
                            onPressed: () {
                              paymentsController.payFarmer(collection);
                            },
                            child: paymentsController.isLoading
                                    .contains(collection.farmerId)
                                ? const CircularProgressIndicator()
                                : const Text("Pay"),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
