import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/onboarding_page_data.dart';

/// A single onboarding page. [pageOffset] is this page's distance (in
/// pages) from the currently centered page — 0 when centered, ±1 when a
/// full page away — driving a scroll-linked parallax (scale/fade/slide).
/// A separate idle animation makes the hero image gently bob in place.
class OnboardingPageView extends StatefulWidget {
  const OnboardingPageView({
    super.key,
    required this.data,
    required this.pageOffset,
  });

  final OnboardingPageData data;
  final double pageOffset;

  @override
  State<OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bobController;

  @override
  void initState() {
    super.initState();
    _bobController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _bobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final offset = widget.pageOffset.clamp(-1.0, 1.0);
    final absOffset = offset.abs();
    final scale = 1 - (absOffset * 0.25);
    final opacity = (1 - absOffset).clamp(0.0, 1.0);
    final heroSlide = offset * 80;
    final textSlide = offset * 32;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _bobController,
            builder: (context, child) {
              final bob = math.sin(_bobController.value * 2 * math.pi) * 6;
              return Transform.translate(
                offset: Offset(heroSlide, bob),
                child: Opacity(
                  opacity: opacity,
                  child: Transform.scale(scale: scale, child: child),
                ),
              );
            },
            child: _Hero(imagePath: widget.data.imagePath),
          ),
          const SizedBox(height: AppSpacing.xl),
          Opacity(
            opacity: opacity,
            child: Transform.translate(
              offset: Offset(textSlide, 0),
              child: Column(
                children: [
                  Text(
                    widget.data.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    widget.data.description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      height: 260,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.16),
                  AppColors.primary.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              imagePath,
              width: 240,
              height: 240,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
