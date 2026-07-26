# Architecture

## Layering

Each feature is split into three layers, present only where a feature
actually needs them:

- **data** — repository interfaces and implementations (`products/data`).
  Only `products` needs this layer; `cart` and `onboarding` don't talk to an
  external source.
- **providers** — Riverpod providers holding state and derived values.
  This is the "business logic" layer: `CartController`, `ProductListNotifier`,
  the filter/sort providers, `OnboardingController`.
- **presentation** — `screens/` (routable, one per `GoRoute`) and `widgets/`
  (feature-local, reusable within that feature only). Cross-feature widgets
  live in `shared/` or `core/widgets`.

`shared/models` holds `Product` and `CartItem` — types more than one feature
needs — so `features/cart` can depend on `features/products`' model without
the two features depending on each other's providers or screens.

## Navigation

`go_router` with a `StatefulShellRoute.indexedStack` for the bottom-nav tabs
(Products, Cart), so each tab keeps its own navigation stack and scroll
position when switching. A single `redirect` callback in `app_router.dart`
gates every route behind onboarding completion, driven by a small
`ChangeNotifier` bridge (`_OnboardingListenable`) that turns the Riverpod
`onboardingCompleteProvider` into something `go_router`'s `refreshListenable`
can watch — this is the one place Riverpod and a non-Riverpod API need to
meet.

## Why not `setState`

The only local `setState` in the app is UI-only, ephemeral state that has no
reason to be shared: which onboarding page is currently visible
(`_OnboardingScreenState._currentPage`) and whether the checkout submit
button is mid-flight (`_isSubmitting`). Everything a second widget might
plausibly need — cart contents, product filters, onboarding completion — is
a provider.

## Scalability

- **Adding a feature** (e.g. order history) means adding
  `features/order_history/{providers,presentation}` and a route; nothing in
  `products` or `cart` needs to change.
- **Swapping the data source**: `ProductRepository` is the only seam the UI
  depends on. A real backend becomes another implementation of that
  interface, wired in via `productRepositoryProvider.overrideWithValue(...)`
  — the same mechanism the test suite already uses to inject
  `FakeProductRepository`.
- **Performance**: `SliverGrid` + `ListView.builder`/`.separated` are used
  everywhere lists can grow, so off-screen items aren't built. Riverpod
  providers are split narrowly (e.g. `cartItemCountProvider` separate from
  `cartItemsProvider`) so a badge count updating doesn't rebuild the full
  cart list, and vice versa.
- **Testing strategy going forward**: because state lives in providers, not
  widgets, new business logic can get a `ProviderContainer`-based unit test
  before any UI exists (see `cart_provider_test.dart`), and new screens can
  be tested by overriding just the providers they read, not the whole app.
