import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCalendaDay extends StatelessWidget {
  final bool hasCollection;
  final DateTime day;
  final double volume;
  final bool selected;
  const CustomCalendaDay({
    super.key,
    required this.day,
    required this.hasCollection,
    required this.volume,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    bool isToday =
        day.year == now.year && day.month == now.month && day.day == now.day;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(4.0),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isToday
                ? Get.theme.colorScheme.primary
                : selected
                    ? Get.theme.colorScheme.secondaryContainer
                    : hasCollection
                        ? Colors.green
                        : Colors.yellow,
            shape: BoxShape.circle,
          ),
          width: 100,
          height: 100,
          child: Center(
            child: Text(
              '${day.day}',
              style: const TextStyle().copyWith(fontSize: 16.0),
            ),
          ),
        ),
        if (hasCollection || isToday)
          Positioned(
            bottom: -2,
            right: 0,
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  hasCollection ? volume.toString() : "0",
                  style: const TextStyle()
                      .copyWith(fontSize: 12.0, color: Colors.black),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
