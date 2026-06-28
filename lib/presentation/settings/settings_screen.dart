import 'package:book_tracker/presentation/app_state.dart';
import 'package:book_tracker/presentation/components/theme_switcher_card.dart';
import 'package:book_tracker/presentation/components/user_info_card.dart';
import 'package:book_tracker/presentation/settings/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsState(appState: context.read<AppState>()),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text(
            'BookTracker',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Consumer<SettingsState>(
          builder: (context, state, child) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Text(
                  'Settings',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Theme',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                ThemeSwitcherCard(
                  isDarkMode: state.appState.themeMode == ThemeMode.dark,
                  onChanged: (value) => state.appState.setThemeMode(
                    value ? ThemeMode.dark : ThemeMode.light,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'User information',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                UserInfoCard(state: state),
              ],
            );
          },
        ),
      ),
    );
  }
}