import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../domain/onboarding_page_data.dart';
import '../../providers/onboarding_provider.dart';
import '../widgets/onboarding_page_view.dart';
import '../widgets/page_indicator.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController();
  late final AnimationController _entranceController;
  int _currentPage = 0;

  bool get _isLastPage => _currentPage == onboardingPages.length - 1;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  void _finish() => ref.read(onboardingCompleteProvider.notifier).complete();

  void _next() {
    if (_isLastPage) {
      _finish();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FadeTransition(
          opacity: CurvedAnimation(
            parent: _entranceController,
            curve: Curves.easeOut,
          ),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.04),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: _entranceController, curve: Curves.easeOutCubic),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: _isLastPage ? 0 : 1,
                      child: IgnorePointer(
                        ignoring: _isLastPage,
                        child: TextButton(
                          onPressed: _finish,
                          child: const Text('Skip'),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, _) {
                      return PageView.builder(
                        controller: _pageController,
                        itemCount: onboardingPages.length,
                        onPageChanged: (index) =>
                            setState(() => _currentPage = index),
                        itemBuilder: (context, index) {
                          final page = _pageController.hasClients
                              ? (_pageController.page ?? _currentPage.toDouble())
                              : _currentPage.toDouble();
                          return OnboardingPageView(
                            data: onboardingPages[index],
                            pageOffset: index - page,
                          );
                        },
                      );
                    },
                  ),
                ),
                PageIndicator(
                  count: onboardingPages.length,
                  currentIndex: _currentPage,
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(scale: animation, child: child),
                    ),
                    child: PrimaryButton(
                      key: ValueKey(_isLastPage),
                      label: _isLastPage ? 'Get Started' : 'Next',
                      onPressed: _next,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
