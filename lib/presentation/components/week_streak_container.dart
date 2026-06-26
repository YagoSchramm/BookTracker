import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeeklyStreakCard extends StatelessWidget {
  final List<bool> daysRead;

  const WeeklyStreakCard({super.key, required this.daysRead})
    : assert(daysRead.length == 7);

  int get currentStreak {
    int streak = 0;

    for (int i = daysRead.length - 1; i >= 0; i--) {
      if (daysRead[i]) {
        streak++;
      } else {
        break;
      }
    }

    return streak;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final now = DateTime.now();
    final days = List<String>.generate(7, (index) {
      final date = now.subtract(Duration(days: 6 - index));
      const labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
      return labels[date.weekday - 1];
    });

    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.flame_fill,
                color: colorScheme.tertiary,
                size: 28,
              ),
              const SizedBox(width: 10),
              Text(
                "$currentStreak Day Streak",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              final completed = daysRead[index];
              final isToday = index == 6;

              return Column(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: completed
                          ? isToday
                                ? colorScheme.primary
                                : colorScheme.secondary
                          : colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      completed
                          ? CupertinoIcons.checkmark_alt
                          : CupertinoIcons.book,
                      size: 18,
                      color: completed
                          ? isToday
                                ? colorScheme.onPrimary
                                : colorScheme.onSecondary
                          : colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    days[index],
                    style: TextStyle(
                      fontWeight: isToday ? FontWeight.bold : FontWeight.w600,
                      color: isToday
                          ? colorScheme.secondary
                          : colorScheme.inverseSurface,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
