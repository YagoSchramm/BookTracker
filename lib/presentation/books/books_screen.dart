import 'package:book_tracker/presentation/add/add_book_screen.dart';
import 'package:book_tracker/presentation/components/book_card.dart';
import 'package:book_tracker/presentation/components/week_streak_container.dart';
import 'package:book_tracker/presentation/books/books_state.dart';
import 'package:book_tracker/presentation/pdf_viewer/pdf_viewer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "BookTracker",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddBookScreen()),
            ),
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    CupertinoIcons.book_fill,
                    size: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Positioned(
                    right: -4,
                    bottom: -7,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        CupertinoIcons.add,
                        size: 10,
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Consumer<BooksState>(
        builder: (context, state, child) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 15),
                Row(
                  children: [
                    SizedBox(width: 12),
                    Text(
                      "Hello, ${state.name}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    SizedBox(width: 12),
                    Text(
                      "Recent activity:",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inverseSurface,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                if (state.filteredBooks.isNotEmpty)
                  SizedBox(
                    height: 275,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.filteredBooks.length,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemBuilder: (context, index) {
                        final book = state.filteredBooks[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BookTile(
                            title: book.title,
                            coverPath: book.coverPath,
                            lastPageRead: book.lastPageRead,
                            totalPages: book.totalPages,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PdfViewerScreen(book: book),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'No books yet. Add one to start tracking.',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 16,
                      ),
                    ),
                  ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                CupertinoIcons.book_fill,
                                size: 28,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(height: 12),

                              Text(
                                "12",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                "Books",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.inverseSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                CupertinoIcons.bookmark_fill,
                                size: 28,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(height: 12),

                              Text(
                                "3",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                "Reading",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.inverseSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                WeeklyStreakCard(
                  daysRead: [true, true, true, false, true, true, true],
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reading Goal",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(
                          value: .8,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "800 / 1000 pages",
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.inverseSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 128),
              ],
            ),
          );
        },
      ),
    );
  }
}
