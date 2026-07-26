import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class _PromoBannerData {
  const _PromoBannerData({
    required this.title,
    required this.colors,
    required this.icon,
  });

  final String title;
  final List<Color> colors;
  final IconData icon;
}

const _banners = [
  _PromoBannerData(
    title: '20% OFF DURING THE WEEKEND',
    colors: [Color(0xFFFF9166), Color(0xFFFF7A45)],
    icon: Icons.shopping_bag_rounded,
  ),
  _PromoBannerData(
    title: '20% OFF ON YOUR FIRST ORDER',
    colors: [Color(0xFF56A8FF), Color(0xFF2F80ED)],
    icon: Icons.local_shipping_rounded,
  ),
];

/// A [PageView] of static promotional banners on the home screen. Purely
/// presentational — no provider or state behind the "Get Now" action.
class PromoBannerCarousel extends StatelessWidget {
  const PromoBannerCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.92),
        itemCount: _banners.length,
        itemBuilder: (context, index) {
          final banner = _banners[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: banner.colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          banner.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: banner.colors.last,
                            disabledBackgroundColor: Colors.white,
                            disabledForegroundColor: banner.colors.last,
                            minimumSize: const Size(0, 36),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                          ),
                          child: const Text('Get Now'),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    banner.icon,
                    size: 56,
                    color: Colors.white.withValues(alpha: 0.35),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
