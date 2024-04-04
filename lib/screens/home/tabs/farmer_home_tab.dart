import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanda_dairy/screens/home/controller/milk_collection_controller.dart';
import 'package:wanda_dairy/screens/home/controller/register_farmer_controller.dart';
import 'package:wanda_dairy/screens/home/tabs/daily_tab_bar.dart';
import 'package:wanda_dairy/screens/home/tabs/monthly_tab_bar.dart';
import 'package:wanda_dairy/screens/home/tabs/weekly_tab_bar.dart';

class FarmerHomeTab extends StatefulWidget {
  const FarmerHomeTab({super.key});

  @override
  State<FarmerHomeTab> createState() => _FarmerHomeTabState();
}

class _FarmerHomeTabState extends State<FarmerHomeTab> {
  MilkCollectionController milkcontroller = Get.put(MilkCollectionController());

  final RegisterFarmerController farmerController =
      Get.put(RegisterFarmerController());

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: "Daily"),
                Tab(text: "Weekly"),
                Tab(text: "Monthly"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  DailyTabBar(),
                  WeeklyTabBar(),
                  MonthlyTabBar(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
