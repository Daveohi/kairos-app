# Kairos

A Flutter prototype for a local same-day product delivery app: onboarding,
a searchable/filterable product catalog, and a cart-to-checkout flow. Built
as a skill-verification case study — see [ASSIGNMENT.md](ASSIGNMENT.md) for
the original brief.

## Getting started

**Requirements**: Flutter 3.29+ (Dart 3.7+), a connected device/emulator or
Chrome for web.

```bash
flutter pub get
flutter run
```

Run the test suite:

```bash
flutter analyze
flutter test
```

## What's implemented

- **Onboarding** — 3-step `PageView` with skip, dot indicator, and a
  persisted "seen onboarding" flag (SharedPreferences) so it only shows once.
- **Product listing** — grid layout, live search, category filter chips,
  sort menu (relevance/price/name), pull-to-refresh, and loading/empty/error
  states with retry.
- **Cart & checkout** — add/increment/decrement/remove line items, an order
  summary (subtotal, delivery fee waived above a threshold, total), and a
  validated checkout form that clears the cart on submit.
- **Navigation** — a bottom-nav shell (Products / Cart, with a live item-count
  badge) built on `go_router`, plus a redirect that gates the app behind
  onboarding until it's completed.

## State management: Riverpod

The app uses `flutter_riverpod` throughout. Reasons for this choice over
Provider/BLoC/GetX:

- **Compile-safe, no `BuildContext` needed** to read state, which keeps
  business logic (e.g. `CartController`, `ProductListNotifier`) testable in
  plain Dart with `ProviderContainer` — no widget tree required (see
  `test/features/cart/cart_provider_test.dart`).
- **Derived state without boilerplate.** `filteredProductsProvider` combines
  the fetched catalog with the search/category/sort providers reactively;
  `cartSubtotalProvider` → `cartDeliveryFeeProvider` → `cartTotalProvider`
  form a small dependency chain that recomputes automatically.
- **`AsyncNotifier`** models the network-ish product fetch with built-in
  loading/data/error states and an explicit `refresh()` for pull-to-refresh
  and retry, instead of hand-rolled loading flags.

## Project structure

Feature-first, so each screen's data, state, and UI live together:

```
lib/
├── main.dart              # bootstraps SharedPreferences + ProviderScope
├── app.dart                # MaterialApp.router + theme
├── core/
│   ├── theme/               # colors, spacing, ThemeData
│   ├── constants/            # app-wide constants (keys, fees)
│   ├── router/                # go_router config + redirect logic
│   ├── providers/              # cross-cutting providers (SharedPreferences)
│   └── widgets/                  # HomeShell (bottom-nav shell)
├── features/
│   ├── onboarding/
│   │   ├── domain/                  # onboarding page content
│   │   ├── providers/                # onboarding-complete state
│   │   └── presentation/screens|widgets
│   ├── products/
│   │   ├── data/                      # ProductRepository + mock data/API
│   │   ├── providers/                  # fetch, search, filter, sort
│   │   └── presentation/screens|widgets
│   └── cart/
│       ├── providers/                   # cart state + derived totals
│       └── presentation/screens|widgets  # cart + checkout
└── shared/
    └── models/                            # Product, CartItem (cross-feature)
```

## Mock API

`ProductRepository` is an interface; `MockProductRepository` is the only
implementation, simulating latency (600ms) and an occasional failure so the
UI's loading/error/retry paths are real. Swapping in a real backend later is
a matter of writing a new `ProductRepository` implementation and overriding
`productRepositoryProvider` — no UI or provider changes required.

## Scalability & testing notes

- New features slot in as new `features/<name>` folders without touching
  existing ones; shared cross-feature types live in `shared/`.
- Providers are narrow and composable (e.g. `cartItemCountProvider` is
  derived, not duplicated state), which keeps widget rebuilds scoped to what
  actually changed.
- Business logic (cart math, filtering/sorting, form validation) is
  isolated from widgets, so it's covered by tests that don't need a device:
  `flutter test` runs a `CartController` unit test suite plus widget tests
  for onboarding, product search/error states, and checkout validation.
- Product images are drawn as icon/color placeholders rather than network
  images, keeping the prototype fully offline and its tests deterministic;
  swapping in `Image.network`/`cached_network_image` per product is a
  localized change to `ProductCard`.
