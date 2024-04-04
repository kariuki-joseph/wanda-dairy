import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wanda_dairy/screens/home/controller/farmer_controller.dart';
import 'package:wanda_dairy/widgets/custom_caledar_day.dart';
import 'package:wanda_dairy/widgets/info_box.dart';

class WeeklyTabBar extends StatefulWidget {
  const WeeklyTabBar({super.key});

  @override
  State<WeeklyTabBar> createState() => _WeeklyTabBarState();
}

class _WeeklyTabBarState extends State<WeeklyTabBar> {
  FarmerController farmerController = Get.put(FarmerController());
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 4,
            children: [
              Text(
                "Here's your Weekly",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "Summary",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
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
                    "${farmerController.weeklyVolume.value}L",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  bottom: Text(
                    "Litres delivered",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  onTap: () {},
                ),
              ),
              Obx(
                () => InfoBox(
                  top: Text(
                    "${farmerController.collectionDates.contains(DateFormat("dd/MM/yyyy").format(DateTime.now())) ? farmerController.weeklyPricePerLitre.value : farmerController.pricePerLitre.value} /-",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  bottom: Text(
                    "per litre",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  onTap: () {},
                ),
              ),
              Obx(
                () => InfoBox(
                  top: Text(
                    "${NumberFormat("#,##0.00").format(farmerController.dailyEarnings.value)} /-",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  bottom: Text(
                    "Weekly Earnings",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TableCalendar(
            focusedDay: focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                this.selectedDay = selectedDay;
                this.focusedDay = focusedDay;
              });

              // get the weekly summary
              farmerController.getWeeklySummary(selectedDay);
            },
            firstDay: DateTime(
              DateTime.now().year,
              DateTime.now().month,
              1,
            ),
            lastDay: DateTime(
              DateTime.now().year,
              DateTime.now().month + 1,
              0,
            ),
            calendarFormat: CalendarFormat.week,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, _) {
                DateTime now = DateTime.now();
                DateTime startOfWeek =
                    now.subtract(Duration(days: now.weekday - 1));
                DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));
                if (day.isAfter(
                        startOfWeek.subtract(const Duration(days: 1))) &&
                    day.isBefore(endOfWeek.add(const Duration(days: 1)))) {
                  return Obx(() {
                    String dayString = DateFormat("dd/MM/yyyy").format(day);
                    return CustomCalendaDay(
                      day: day,
                      hasCollection:
                          farmerController.collectionDates.contains(dayString),
                      volume: farmerController.totalVolume[dayString] ?? 0.0,
                      selected: selectedDay == day,
                    );
                  });
                } else {
                  return Text(
                    '${day.day}',
                    style: const TextStyle().copyWith(fontSize: 16.0),
                  );
                }
              },
              selectedBuilder: (context, day, _) {
                return Obx(() {
                  String dayString = DateFormat("dd/MM/yyyy").format(day);
                  return CustomCalendaDay(
                    day: day,
                    hasCollection:
                        farmerController.collectionDates.contains(dayString),
                    volume: farmerController.totalVolume[dayString] ?? 0.0,
                    selected: selectedDay == day,
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
