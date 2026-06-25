import 'package:book_tracker/presentation/home/home_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<HomeState>(
      builder: (context, state, child) {
        return Scaffold(
          body: Stack(
            children: [
              IndexedStack(
                index: state.currentIndex,
                children: state.screens,
              ),

              Positioned(
                left: 36,
                right: 36,
                bottom: 24,
                child: SafeArea(
                  top: false,
                  child: Container(
                    height: 72,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        state.currentIndex == 0
                            ? Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  CupertinoIcons.book_fill,
                                  color: theme.colorScheme.onPrimary,
                                  size: 24,
                                ),
                              )
                            : IconButton(
                                icon: const Icon(
                                  CupertinoIcons.book_fill,
                                ),
                                color: theme.colorScheme.onSurface
                                    .withOpacity(0.45),
                                iconSize: 24,
                                onPressed: () =>
                                    state.changeIndex(0, context),
                              ),

                        state.currentIndex == 1
                            ? Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  CupertinoIcons.collections_solid,
                                  color: theme.colorScheme.onPrimary,
                                  size: 24,
                                ),
                              )
                            : IconButton(
                                icon: const Icon(
                                  CupertinoIcons.collections_solid,
                                ),
                                color: theme.colorScheme.onSurface
                                    .withOpacity(0.45),
                                iconSize: 24,
                                onPressed: () =>
                                    state.changeIndex(1, context),
                              ),

                        state.currentIndex == 2
                            ? Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.settings_outlined,
                                  color: theme.colorScheme.onPrimary,
                                  size: 24,
                                ),
                              )
                            : IconButton(
                                icon: const Icon(
                                  Icons.settings_outlined,
                                ),
                                color: theme.colorScheme.onSurface
                                    .withOpacity(0.45),
                                iconSize: 24,
                                onPressed: () =>
                                    state.changeIndex(2, context),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}