import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanda_dairy/screens/home/controller/milk_collection_controller.dart';
import 'package:wanda_dairy/screens/home/controller/register_farmer_controller.dart';
import 'package:wanda_dairy/widgets/info_box.dart';

class FarmerHomeTab extends StatelessWidget {
  MilkCollectionController milkcontroller = Get.put(MilkCollectionController());
  RegisterFarmerController farmerController =
      Get.put(RegisterFarmerController());

  FarmerHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          "Good Morning Farmer",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 20),
        Text(
          "Here's your daily",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          "summary",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 10,
          spacing: 10,
          children: [
            Obx(
              () => InfoBox(
                top: Text(
                  milkcontroller.litresCollectedToday.value.toString(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                bottom: Text(
                  "Litres delivered",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                onTap: () {},
              ),
            ),
            InfoBox(
              top: Text(
                "40 /-",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              bottom: Text(
                "per litre",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              onTap: () {},
            ),
           Obx(() =>  InfoBox(
              top: Text(
                "${milkcontroller.litresCollectedToday.value * 40} /-",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              bottom: Text(
                "Daily Earnings",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              onTap: () {},
            ),)
          ],
        ),
        const SizedBox(height: 20),
        const Expanded(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.center,
                  tabs: [
                    Tab(
                      text: "Daily",
                    ),
                    Tab(
                      text: "Monthly",
                    )
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Daily"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Monthly"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
