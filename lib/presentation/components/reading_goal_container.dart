import 'package:book_tracker/entities/user.dart';
import 'package:flutter/material.dart';

class ReadingGoalContainer extends StatelessWidget {
  final User? user;

  const ReadingGoalContainer({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final goal = user?.pageGoal ?? 0;
    final pagesRead = user?.pagesRead ?? 0;
    final progress = goal > 0 ? (pagesRead / goal).clamp(0.0, 1.0) : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reading Goal',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              borderRadius: BorderRadius.circular(12),
              backgroundColor: colorScheme.surfaceVariant,
              color: colorScheme.primary,
              minHeight: 10,
            ),
            const SizedBox(height: 8),
            Text(
              goal > 0
                  ? '$pagesRead / $goal total pages'
                  : 'No page goal set',
              style: TextStyle(
                color: colorScheme.inverseSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
