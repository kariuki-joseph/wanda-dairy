import 'package:flutter/material.dart';
import 'package:wanda_dairy/widgets/custom_input.dart';
import 'package:wanda_dairy/widgets/info_box.dart';
import 'package:wanda_dairy/widgets/primary_button.dart';
import 'package:wanda_dairy/widgets/secondary_button.dart';

class DairyHomeTab extends StatelessWidget {
  const DairyHomeTab({
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
            InfoBox(
              top: Text(
                "150",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              bottom: Text(
                "Litres Collected",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {},
            ),
            InfoBox(
              top: Text(
                "6",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              bottom: Text(
                "Farmers",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {},
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
          child: DataTable(
            columns: const [
              DataColumn(
                label: Text('Farmer Name'),
              ),
              DataColumn(
                label: Text('Volume of Milk (Ltrs)'),
              ),
            ],
            rows: const [
              DataRow(
                cells: [
                  DataCell(Text('Farmer 1')),
                  DataCell(Text('100')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('Farmer 2')),
                  DataCell(Text('200')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('Farmer 3')),
                  DataCell(Text('300')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('Farmer 4')),
                  DataCell(Text('400')),
                ],
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: SecondaryButton(
            onPressed: () {
              showBottomSheet(
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
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const CustomTextFormField(
                      labelText: "Farmer's Name",
                      hintText: "Enter Farmer's Name",
                    ),
                    const SizedBox(height: 10),
                    const CustomTextFormField(
                      labelText: "Date of Delivery",
                      hintText: "10/01/2028",
                      keyboardType: TextInputType.datetime,
                    ),
                    const SizedBox(height: 10),
                    const CustomTextFormField(
                      labelText: "Volume of Milk",
                      hintText: "Volume of Milk (Litres)",
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                    ),
                    const SizedBox(height: 10),
                    const CustomTextFormField(
                      labelText: "Price per Litre",
                      hintText: "Price per",
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      enabled: false,
                      initialValue: "Ksh 0.0",
                      decoration: InputDecoration(
                        labelText: "Total Due",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    PrimaryButton(
                      onPressed: () {},
                      child: const Text("Save"),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
