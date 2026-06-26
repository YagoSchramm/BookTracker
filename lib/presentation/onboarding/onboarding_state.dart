import 'package:book_tracker/global.dart';
import 'package:flutter/material.dart';

class OnboardingState extends ChangeNotifier {
  OnboardingState() {
    _loadOnboardingStatus();
  }

  bool isLoading = true;
  bool showOnboarding = false;
  int currentPage = 0;
  int pageGoal = 20;
  final TextEditingController nameController = TextEditingController();
  final PageController pageController = PageController();

  Future<void> _loadOnboardingStatus() async {
    final completed = await userService.hasCompletedOnboarding();
    showOnboarding = !completed;
    isLoading = false;
    notifyListeners();
  }

  void updateCurrentPage(int page) {
    currentPage = page;
    notifyListeners();
  }

  Future<void> previousPage() async {
    if (currentPage > 0) {
      await pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void updatePageGoal(double value) {
    pageGoal = value.round();
    notifyListeners();
  }

  Future<void> nextPage(BuildContext context) async {
    if (currentPage < 2) {
      await pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      return;
    }

    await completeOnboarding(context);
  }

  String get username => nameController.text.trim();

  Future<void> completeOnboarding(BuildContext context) async {
    final name = username;
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Digite seu nome para continuar.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    await userService.createUser(name, pageGoal);
    showOnboarding = false;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    pageController.dispose();
    super.dispose();
  }
}
