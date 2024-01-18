import 'package:flutter/material.dart';
import 'package:wanda_dairy/widgets/custom_input.dart';
import 'package:wanda_dairy/widgets/primary_button.dart';
import 'package:wanda_dairy/widgets/secondary_button.dart';

class RegisterFarmer extends StatelessWidget {
  const RegisterFarmer({super.key});

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
              scrollDirection: Axis.horizontal,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DataTable(
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
                    rows: [
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              "John Doe",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          DataCell(
                            Text(
                              "john@gmail.com",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          DataCell(
                            Text(
                              "0713275451",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              "John Doe",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          DataCell(
                            Text(
                              "john@gmail.com",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          DataCell(
                            Text(
                              "0713275451",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              "John Doe",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          DataCell(
                            Text(
                              "john@gmail.com",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          DataCell(
                            Text(
                              "0713275451",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              "John Doe",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          DataCell(
                            Text(
                              "john@gmail.com",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          DataCell(
                            Text(
                              "0713275451",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SecondaryButton(
              onPressed: () {
                showBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return buildRegisterBottomSheet(context);
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

  Widget buildRegisterBottomSheet(BuildContext context) {
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
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const CustomTextFormField(
                      labelText: "Farmer's Name",
                      hintText: "Enter Farmer Name",
                    ),
                    const SizedBox(height: 10),
                    const CustomTextFormField(
                      labelText: "Farmer's Email",
                      hintText: "Enter Farmer Email",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 10),
                    const CustomTextFormField(
                      labelText: "Farmer's Phone",
                      hintText: "Enter Farmer Phone",
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 10),
                    const CustomTextFormField(
                      labelText: "Farmer's Password",
                      hintText: "Enter Password",
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                    const SizedBox(height: 10),
                    PrimaryButton(
                      onPressed: () {},
                      child: const Text("Save"),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
