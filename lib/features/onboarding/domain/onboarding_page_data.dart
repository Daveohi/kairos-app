import 'package:flutter/material.dart';

class OnboardingPageData {
  const OnboardingPageData({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

const onboardingPages = [
  OnboardingPageData(
    icon: Icons.bolt_rounded,
    title: 'Same-day delivery',
    description:
        'Order from local shops and get everything delivered to your '
        'door in hours, not days.',
  ),
  OnboardingPageData(
    icon: Icons.storefront_rounded,
    title: 'Browse local favorites',
    description:
        'Discover products from stores near you, all in one simple, '
        'searchable catalog.',
  ),
  OnboardingPageData(
    icon: Icons.shopping_bag_rounded,
    title: 'Checkout in seconds',
    description:
        'Add items to your cart and check out with a fast, simple, '
        'guided flow.',
  ),
];
