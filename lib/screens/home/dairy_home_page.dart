import 'package:flutter/material.dart';
import 'package:wanda_dairy/screens/home/tabs/dairy_home_tab.dart';
import 'package:wanda_dairy/screens/home/tabs/payments.dart';
import 'package:wanda_dairy/screens/home/tabs/register_farmer.dart';

class DairyHomePage extends StatefulWidget {
  const DairyHomePage({super.key});

  @override
  State<DairyHomePage> createState() => _DairyHomePageState();
}

class _DairyHomePageState extends State<DairyHomePage> {
  int _currentIndex = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(
                () {
                  _currentIndex = index;
                },
              );
            },
            children: [
              DairyHomeTab(),
              RegisterFarmer(),
              const Payments(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.create_new_folder),
              label: 'Register Farmer',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_card),
              label: 'Payments',
            ),
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
}
