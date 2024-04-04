import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wanda_dairy/screens/home/controller/farmer_controller.dart';
import 'package:wanda_dairy/widgets/custom_caledar_day.dart';
import 'package:wanda_dairy/widgets/info_box.dart';

class DailyTabBar extends StatefulWidget {
  const DailyTabBar({super.key});

  @override
  State<DailyTabBar> createState() => _DailyTabBarState();
}

class _DailyTabBarState extends State<DailyTabBar> {
  FarmerController farmerController = Get.put(FarmerController());
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  DateTime now = DateTime.now();

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
                "Here's your Daily",
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
                    "${farmerController.dailyVolume.value}L",
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
                    "${farmerController.collectionDates.contains(DateFormat("dd/MM/yyyy").format(DateTime.now())) ? farmerController.dailyPricePerLitre.value : farmerController.pricePerLitre.value} /-",
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
                    "Daily Earnings",
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
              return isSameDay(focusedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                this.selectedDay = selectedDay;
                this.focusedDay = focusedDay;
              });
              // display the summaries for this day
              farmerController.getDailySummary(selectedDay);
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              todayTextStyle: const TextStyle().copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            // display only the current week
            firstDay: now.subtract(Duration(days: now.weekday - 1)),
            lastDay: now
                .subtract(Duration(days: now.weekday - 1))
                .add(const Duration(days: 6)),
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
