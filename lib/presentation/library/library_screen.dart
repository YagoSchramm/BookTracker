import 'package:book_tracker/presentation/components/book_card.dart';
import 'package:book_tracker/presentation/library/library_state.dart';
import 'package:book_tracker/presentation/pdf_viewer/pdf_viewer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
void didChangeDependencies() {
  super.didChangeDependencies();
  final libraryState = context.read<LibraryState>();
  libraryState.loadBooks();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'BookTracker',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Consumer<LibraryState>(
        builder: (context, state, child) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  onChanged: state.updateSearch,
                  decoration: InputDecoration(
                    hintText: 'Search books...',
                    prefixIcon: const Icon(CupertinoIcons.search),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    ChoiceChip(
                      label: const Text('All'),
                      selected: state.selectedFilter == 'all',
                      onSelected: (selected) {
                        if (selected) state.updateFilter('all');
                      },
                      selectedColor: Theme.of(context).colorScheme.primary,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      side: BorderSide.none,
                      labelStyle: TextStyle(
                        color: state.selectedFilter == 'all'
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('Reading'),
                      selected: state.selectedFilter == 'reading',
                      onSelected: (selected) {
                        if (selected) state.updateFilter('reading');
                      },
                      selectedColor: Theme.of(context).colorScheme.primary,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      side: BorderSide.none,
                      labelStyle: TextStyle(
                        color: state.selectedFilter == 'reading'
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('Finished'),
                      selected: state.selectedFilter == 'finished',
                      onSelected: (selected) {
                        if (selected) state.updateFilter('finished');
                      },
                      selectedColor: Theme.of(context).colorScheme.primary,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      side: BorderSide.none,
                      labelStyle: TextStyle(
                        color: state.selectedFilter == 'finished'
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              if (state.filteredBooks.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      'No books found.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
