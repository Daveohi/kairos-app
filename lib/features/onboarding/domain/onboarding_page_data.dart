import '../../../core/constants/app_images.dart';

class OnboardingPageData {
  const OnboardingPageData({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  final String imagePath;
  final String title;
  final String description;
}

const onboardingPages = [
  OnboardingPageData(
    imagePath: AppImages.onboarding1,
    title: 'Same-day delivery',
    description:
        'Order from local shops and get everything delivered to your '
        'door in hours, not days.',
  ),
  OnboardingPageData(
    imagePath: AppImages.onboarding2,
    title: 'Browse local favorites',
    description:
        'Discover products from stores near you, all in one simple, '
        'searchable catalog.',
  ),
  OnboardingPageData(
    imagePath: AppImages.onboarding3,
    title: 'Checkout in seconds',
    description:
        'Add items to your cart and check out with a fast, simple, '
        'guided flow.',
  ),
];
