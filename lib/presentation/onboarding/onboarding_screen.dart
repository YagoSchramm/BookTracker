import 'package:book_tracker/presentation/components/custom_text_field.dart';
import 'package:book_tracker/presentation/onboarding/onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Consumer<OnboardingState>(
            builder: (context, state, child) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                children: [
                  Expanded(
                    child: PageView(
                      controller: state.pageController,
                      onPageChanged: state.updateCurrentPage,
                      children: [
                        _buildWelcomePage(theme),
                        _buildNamePage(state, theme),
                        _buildPageGoalPage(state, theme),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 48,
                        child: state.currentPage > 0
                            ? IconButton(
                                onPressed: state.previousPage,
                                icon: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: theme.colorScheme.primary,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                      Expanded(child: _buildPageIndicator(state, theme)),
                      SizedBox(
                        width: 48,
                        child: state.currentPage < 2
                            ? IconButton(
                                onPressed: () => state.nextPage(context),
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: theme.colorScheme.primary,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (state.currentPage == 2)
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () => state.nextPage(context),
                        child: Text(
                          'Finish',
                          style: TextStyle(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomePage(ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/initial_page_image.png',
          width: 360,
          height: 360,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 32),
        Text(
          'Welcome to BookTracker',
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Organize your reading, track goals, and build better habits.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildNamePage(OnboardingState state, ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'What is your name?',
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 24),
        CustomTextField(
          label: 'Name',
          controller: state.nameController,
          hint: 'Enter your name',
        ),
      ],
    );
  }

  Widget _buildPageGoalPage(OnboardingState state, ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Set your total page goal',
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          '${state.pageGoal} total pages',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        Slider(
          activeColor: theme.colorScheme.primary,
          inactiveColor: theme.colorScheme.primary.withOpacity(0.3),
          min: 5,
          max: 500,
          divisions: 99,
          value: state.pageGoal.toDouble(),
          label: '${state.pageGoal}',
          onChanged: state.updatePageGoal,
        ),
      ],
    );
  }

  Widget _buildPageIndicator(OnboardingState state, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: state.currentPage == index ? 24 : 10,
          height: 10,
          decoration: BoxDecoration(
            color: state.currentPage == index
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
