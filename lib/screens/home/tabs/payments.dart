// wanda dairy payments
import 'package:flutter/material.dart';

class Payments extends StatelessWidget {
  const Payments({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Payment Details'),
      ),
      body: const Center(
        child: Text('Farmers info and pay button ....'),
      ),
    );
  }
}
