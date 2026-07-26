import 'package:flutter/material.dart';

import '../../../core/constants/app_images.dart';
import '../../../shared/models/product.dart';

final mockProducts = <Product>[
  const Product(
    id: 'p1',
    name: 'Apple Watch Series 2',
    category: 'Smartwatch',
    price: 45000,
    originalPrice: 55000,
    unit: 'per unit',
    icon: Icons.watch_rounded,
    color: Color(0xFF1A1D1F),
    imagePath: AppImages.appleWatchSeries2,
    rating: 4.6,
    description:
        'Aluminum-case Apple Watch Series 2 with a sport band, fitness '
        'tracking, and a bright always-legible display.',
  ),
  const Product(
    id: 'p2',
    name: 'Apple Watch Series 3',
    category: 'Smartwatch',
    price: 45000,
    originalPrice: 55000,
    unit: 'per unit',
    icon: Icons.watch_rounded,
    color: Color(0xFF1A1D1F),
    imagePath: AppImages.appleWatchSeries3,
    rating: 4.7,
    description:
        'Stainless steel Apple Watch Series 3 with cellular connectivity, '
        'heart-rate sensor, and a sport band.',
  ),
  const Product(
    id: 'p3',
    name: 'Casio Edifice Chronograph',
    category: 'Analog',
    price: 45000,
    originalPrice: 55000,
    unit: 'per unit',
    icon: Icons.watch_outlined,
    color: Color(0xFF2D2F31),
    imagePath: AppImages.casioEdifice,
    rating: 4.5,
    description:
        'Casio Edifice world-time chronograph with a leather strap and '
        'stainless steel case, built for everyday precision.',
  ),
  const Product(
    id: 'p4',
    name: 'Georg Jensen Chronograph',
    category: 'Analog',
    price: 45000,
    originalPrice: 55000,
    unit: 'per unit',
    icon: Icons.watch_outlined,
    color: Color(0xFFC98A4B),
    imagePath: AppImages.chronographClockJewellery,
    rating: 4.8,
    description:
        'Minimalist Georg Jensen dress watch with a tan leather strap and '
        'brushed steel case, a timeless everyday classic.',
  ),
  const Product(
    id: 'p5',
    name: 'Digital Fitness Watch',
    category: 'Digital',
    price: 45000,
    unit: 'per unit',
    icon: Icons.fitness_center_rounded,
    color: Color(0xFF14151A),
    imagePath: AppImages.digitalWatchBlack,
    rating: 4.3,
    description:
        'Slim digital fitness band with a bright touch display for time, '
        'steps, and notifications on the go.',
  ),
  const Product(
    id: 'p6',
    name: 'Mido Multifort Automatic',
    category: 'Analog',
    price: 45000,
    originalPrice: 55000,
    unit: 'per unit',
    icon: Icons.watch_outlined,
    color: Color(0xFF1B1B1B),
    imagePath: AppImages.midoAutomaticWatch,
    rating: 4.9,
    description:
        'Mido Multifort automatic watch with a power-reserve indicator and '
        'a stitched leather strap, Swiss-made craftsmanship.',
  ),
  const Product(
    id: 'p7',
    name: 'Rugged Smartwatch',
    category: 'Smartwatch',
    price: 45000,
    originalPrice: 55000,
    unit: 'per unit',
    icon: Icons.watch_rounded,
    color: Color(0xFFFF7A45),
    imagePath: AppImages.portableSmartWatch,
    rating: 4.2,
    description:
        'Rugged outdoor smartwatch with an app-tile touch display and a '
        'shock-resistant orange-accented case.',
  ),
  const Product(
    id: 'p8',
    name: 'Steel Chronograph Duo',
    category: 'Analog',
    price: 45000,
    originalPrice: 55000,
    unit: 'per unit',
    icon: Icons.watch_outlined,
    color: Color(0xFF56617A),
    imagePath: AppImages.roundSilverChronographWatch,
    rating: 4.4,
    description:
        'Stainless steel chronograph with a link bracelet, available in '
        'classic silver or midnight blue dial.',
  ),
  const Product(
    id: 'p9',
    name: 'Smart Fitness Band',
    category: 'Smartwatch',
    price: 45000,
    originalPrice: 55000,
    unit: 'per unit',
    icon: Icons.watch_rounded,
    color: Color(0xFF16171A),
    imagePath: AppImages.smartWatchIsolated,
    rating: 4.3,
    description:
        'Compact smart fitness band with heart-rate and sleep tracking, '
        'paired with a soft silicone strap.',
  ),
];
