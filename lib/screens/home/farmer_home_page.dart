import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanda_dairy/screens/home/controller/farmer_controller.dart';
import 'package:wanda_dairy/screens/home/tabs/farmer_home_tab.dart';
import 'package:wanda_dairy/screens/home/tabs/farmer_invoice_tab.dart';
import 'package:wanda_dairy/screens/home/tabs/profile_tab.dart';

class FarmerHomePage extends StatefulWidget {
  const FarmerHomePage({super.key});

  @override
  State<FarmerHomePage> createState() => _FarmerHomePageState();
}

class _FarmerHomePageState extends State<FarmerHomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final FarmerController farmerController = Get.put(FarmerController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Obx(
            () => Text(
              "Good ${getTimeOfDay()} ${farmerController.loggedInUser.value.name.split(" ")[0]}",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: [
              const FarmerHomeTab(),
              FarmerInvoiceTab(),
              ProfileTab(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_card),
              label: "Invoice",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: "Profile",
            )
          ],
          onTap: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeIn,
            );
          },
        ),
      ),
    );
  }

  String getTimeOfDay() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Morning";
    }
    if (hour < 17) {
      return "Afternoon";
    }
    return "Evening";
  }
}
