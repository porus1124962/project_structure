# Flutter GetX Starter Template

[![Flutter CI](https://github.com/YOUR_USERNAME/YOUR_REPO/actions/workflows/flutter_ci.yml/badge.svg)](https://github.com/YOUR_USERNAME/YOUR_REPO/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![GetX](https://img.shields.io/badge/State-GetX-blueviolet)](https://pub.dev/packages/get)

A **production-ready Flutter starter template** following the GetX MVC pattern.
Clone it, rename your app, swap the API URLs, and you have a solid foundation to build on.

---

## ✨ Features

| Category | What's included |
|---|---|
| **Architecture** | GetX MVC — Bindings → Controllers → Views |
| **Routing** | Named routes with `AppPages` / `AppRoutes` |
| **Theming** | Full Material 3 light & dark themes, persisted preference |
| **Network** | Dio client, connectivity retry interceptor, env-based URLs |
| **Storage** | `GetStorage` wrapper with typed `StorageKeys` |
| **Localisation** | GetX translation system — English + Arabic included |
| **Error handling** | Global `FlutterError` + `PlatformDispatcher` boundary |
| **Onboarding** | 3-page onboarding with skip logic |
| **Bottom nav** | 4-tab shell with placeholder screens |
| **Widgets** | `CustomButton`, `CustomTextField`, `AppCard`, `AppLoader`, `EmptyStateWidget` |
| **CI/CD** | GitHub Actions — lint · test · build Android + iOS |
| **Tests** | Smoke test, controller unit tests, model unit tests |

---

## 🗂 Project Structure

```
lib/
├── bindings/          # GetX dependency injection
├── controllers/       # Business logic (GetxController)
├── l10n/              # Translations (GetX system)
│   └── translations/  # Per-locale string maps
├── models/            # Data classes (BaseModel pattern)
├── routes/            # AppPages + AppRoutes
├── services/
│   ├── constants/     # AppConstants, StorageKeys
│   ├── Network/       # Dio API client, interceptor, Url config
│   └── error_handler.dart
├── theme/             # AppColors, AppTextStyles, light/dark ThemeData
├── utils/             # AutoSizeText, loader, text helpers
├── views/             # One folder per screen
│   ├── auth/
│   ├── bottom_bar/
│   ├── home/
│   ├── intro/         # Alternative image-based intro (optional)
│   ├── onboarding/
│   ├── settings/
│   └── splash/
└── widgets/           # Reusable UI components
```

---

## 🚀 Getting Started

### Prerequisites

| Tool | Version |
|---|---|
| Flutter | 3.x (stable) |
| Dart | 3.x |
| Android Studio / Xcode | latest |

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
cd YOUR_REPO

# 2. Install dependencies
flutter pub get

# 3. Run on a device / emulator
flutter run --dart-define=ENVIRONMENT=dev
```

### Build for release

```bash
# Android
flutter build apk --release --dart-define=ENVIRONMENT=production

# iOS
flutter build ios --release --dart-define=ENVIRONMENT=production
```

---

## ⚙️ Configuration

### 1 · Rename the app

| File | What to change |
|---|---|
| `lib/main.dart` | `title: 'My App'` |
| `android/app/build.gradle.kts` | `applicationId`, `namespace` |
| `ios/Runner/Info.plist` | `CFBundleDisplayName`, `CFBundleIdentifier` |
| `pubspec.yaml` | `name`, `description` |

### 2 · API URLs

Open `lib/services/Network/Url.dart` and replace the placeholder URLs:

```dart
class DevConfig implements BaseConfig {
  @override String get apiUrl => 'https://dev-api.YOUR-DOMAIN.com/api/';
  // …
}

class ProductionConfig implements BaseConfig {
  @override String get apiUrl => 'https://api.YOUR-DOMAIN.com/api/';
  // …
}
```

Select the environment at build time:
```bash
flutter run  --dart-define=ENVIRONMENT=dev         # default
flutter run  --dart-define=ENVIRONMENT=production
```

### 3 · Firebase (optional)

See the guide in `lib/config.dart` and `lib/notification.dart`.

### 4 · Custom fonts (optional)

1. Drop font files into `assets/fonts/`.
2. Register them in the `fonts:` section of `pubspec.yaml`.
3. Uncomment the `fontFamily` lines in `lib/utils/TextStyle.dart`.

---

## 🌐 Localisation

Strings live in `lib/l10n/translations/`. English & Arabic are provided.

**Add a new locale:**
1. Create `lib/l10n/translations/fr_fr.dart` with a `frFR` map.
2. Import it in `lib/l10n/app_translations.dart` and add it to `keys` and `supportedLocales`.
3. Switch the locale at runtime:
   ```dart
   Get.updateLocale(const Locale('fr', 'FR'));
   ```

**Use in widgets:**
```dart
Text('login'.tr)   // → 'Login' / 'تسجيل الدخول' / …
```

---

## 🏗 Architecture

```
┌─────────────┐    ┌──────────────┐    ┌──────────────┐
│   Binding   │───▶│  Controller  │◀───│     View     │
│ (GetX DI)   │    │ (GetxCtrl)   │    │ (GetView<C>) │
└─────────────┘    └──────┬───────┘    └──────────────┘
                          │
              ┌───────────┴───────────┐
              │     Service / API     │
              │  (singleton, Dio)     │
              └───────────────────────┘
```

**Convention per screen:**

```
views/home/home_view.dart          → StatelessWidget (GetView<HomeController>)
controllers/home_controller.dart   → GetxController
bindings/home_binding.dart         → Bindings (lazyPut controller)
```

---

## 🧪 Running Tests

```bash
# All tests
flutter test

# With coverage report
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

**Test layout:**

```
test/
├── helpers/
│   └── app_test_helper.dart     # shared setUp helpers
├── unit/
│   ├── theme_controller_test.dart
│   └── onboarding_controller_test.dart
└── widget_test.dart             # smoke test + UserModel tests
```

> **Adding mocks:** Install [`mocktail`](https://pub.dev/packages/mocktail) and create fakes for `Api`, `GetStorage`, etc. to test controllers in full isolation.

---

## 🤖 CI / CD

GitHub Actions workflow at `.github/workflows/flutter_ci.yml`:

| Job | Runner | Trigger |
|---|---|---|
| Analyse & Test | ubuntu | push / PR |
| Build Android debug | ubuntu | after tests pass |
| Build iOS debug | macos | after tests pass |

Configure `CODECOV_TOKEN` in **GitHub → Settings → Secrets** to enable coverage reporting.

---

## 🔒 Security Notes

- **Never commit** `lib/firebase_options.dart`, `.env`, or any file with real credentials.
- API keys and tokens belong in CI/CD secrets or a secrets manager — not in source code.
- `StorageKeys.password` has been removed. Use [`flutter_secure_storage`](https://pub.dev/packages/flutter_secure_storage) for sensitive data.

---

## 🤝 Contributing

1. Fork the repo and create a feature branch: `git checkout -b feat/your-feature`
2. Commit your changes following [Conventional Commits](https://www.conventionalcommits.org/).
3. Run `flutter analyze && flutter test` — both must pass.
4. Open a Pull Request against `main`.

---

## 📄 License

This project is licensed under the **MIT License** — see [LICENSE](LICENSE) for details.
