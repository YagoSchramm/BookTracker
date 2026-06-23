import 'package:flutter/material.dart';

class BookTile extends StatelessWidget {
  final String title;
  final int lastPageRead;
  final int totalPages;
  final VoidCallback? onTap;

  const BookTile({
    super.key,
    required this.title,
    required this.lastPageRead,
    required this.totalPages,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final progress =
        totalPages > 0 ? lastPageRead / totalPages : 0.0;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Capa
            Container(
              height: 190,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                    color: Colors.black.withValues(alpha: .08),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.menu_book_rounded,
                  size: 42,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 6),

            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 5,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              "$lastPageRead/$totalPages",
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}