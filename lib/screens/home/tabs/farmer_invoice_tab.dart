import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wanda_dairy/screens/home/controller/invoice_controller.dart';
import 'package:wanda_dairy/widgets/secondary_button.dart';

class FarmerInvoiceTab extends StatelessWidget {
  FarmerInvoiceTab({super.key});
  final InvoiceController invoiceController =
      Get.put(InvoiceController()); // Get the instance of InvoiceController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Invoice Details',
              style: Get.theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Text(
              "Select the month you want to generate invoice for",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    invoiceController.monthYear.value = DateTime(
                        invoiceController.monthYear.value.year,
                        invoiceController.monthYear.value.month - 1);
                  },
                ),
                ValueListenableBuilder<DateTime>(
                  valueListenable: invoiceController.monthYear,
                  builder: (context, date, _) {
                    return Text(
                      DateFormat.yMMMM().format(date),
                      style: const TextStyle(fontSize: 20),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {
                    invoiceController.monthYear.value = DateTime(
                        invoiceController.monthYear.value.year,
                        invoiceController.monthYear.value.month + 1);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(
                () => SingleChildScrollView(
                  child: invoiceController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : !invoiceController.hasInvoice.value
                          ? Center(
                              child: RichText(
                                text: TextSpan(
                                  text: "You have no invoice data for ",
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: DateFormat("MMMM yyyy").format(
                                          invoiceController.monthYear.value),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : DataTable(
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
                                  fontSize: 12),
                              headingRowColor: MaterialStateProperty.all(
                                Get.theme.colorScheme.surfaceVariant,
                              ),
                              columns: const [
                                DataColumn(label: Text("Date")),
                                DataColumn(label: Text("Volume")),
                                DataColumn(label: Text("Price (Ksh.)")),
                                DataColumn(label: Text("Status")),
                              ],
                              rows: invoiceController.milkCollections
                                  .map((collection) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              DateFormat("dd/MM/yyyy").format(
                                                  collection.collectionDate),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                                "${collection.volumeInLitres}L"),
                                          ),
                                          DataCell(
                                            Text(
                                              NumberFormat("#,##0.00").format(
                                                  collection.pricePerLitre *
                                                      collection
                                                          .volumeInLitres),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              collection.isPaid
                                                  ? "Paid"
                                                  : "Not  Paid",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: collection.isPaid
                                                    ? Colors.green[300]
                                                    : Colors.red[300],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ))
                                  .toList(),
                            ),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
      floatingActionButton: Obx(
        () => SecondaryButton(
          isEnabled: invoiceController.hasInvoice.value,
          onPressed: () {
            invoiceController.generateInvoice();
          },
          label: Text(
            invoiceController.isGeneratingPdf.value
                ? "Generating ..."
                : "Generate Invoice",
          ),
          icon: invoiceController.isGeneratingPdf.value
              ? const SizedBox(
                  width: 10,
                  height: 10,
                  child: CircularProgressIndicator(),
                )
              : const Icon(Icons.add_card),
        ),
      ),
    );
  }
}
