import 'package:flutter/material.dart';

class FarmerInvoiceTab extends StatelessWidget {
  const FarmerInvoiceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Text("Download your monthly invoices here..."),
        ),
      ),
    );
  }
}
