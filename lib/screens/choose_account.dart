import 'package:flutter/material.dart';
import 'package:wanda_dairy/widgets/info_box.dart';

class ChooseAccount extends StatelessWidget {
  const ChooseAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Continue as?',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InfoBox(
                  top: Image.asset("images/grocery.png"),
                  bottom: const Text("Wanda Dairy Company"),
                  onTap: () {},
                ),
                InfoBox(
                  top: const Icon(Icons.delivery_dining),
                  bottom: const Text("Farmer"),
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
