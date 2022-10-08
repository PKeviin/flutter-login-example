# Template
Flutter app template (Android and iOS)

### Getting Started
Editing `.env.dev`, `.env.preprod`, `.env.prod` files and add `.env*` to `.gitignore` file
Run `main_dev.dart`, `main_preprod.dart`, `main_prod.dart`

##### Build release command line
iOS : `flutter build ios -t lib/main_prod.dart --release`
Android : `flutter build appbundle -t lib/main_prod.dart --release`

##### Build runner command line for [freezed](https://pub.dev/packages/freezed)
`flutter pub run build_runner build --delete-conflicting-outputs`


### Informations
1. Implementation of `FakeLoginRemoteDataSourceImpl`, Using `LoginRemoteDataSourceImpl` to implement real login
2. Added a listener in the `app.dart` file to display a global failure snackbar
3. Added a listener in the `app.dart` file to display a global loader overlay with [loader_overlay](https://pub.dev/packages/loader_overlay)
4. Implementation of `privacy_provider.dart` to manage user's privacy status
5. Saving user in phone, Using [local_auth](https://pub.dev/packages/local_auth) to re-login with biometrics


### Package used
1. [Riverpod](https://pub.dev/packages/flutter_riverpod) implementation for state-management
2. Using [go_router](https://pub.dev/packages/go_router) and `ChangeNotifier` to handle redirects
3. [Wiredash](https://pub.dev/packages/wiredash) implementation in `app.dart` file to manage feedbacks
4. Implemented [sentry_flutter](https://pub.dev/packages/sentry_flutter) in `main_prepod.dart` and `main_prod.dart` to capture errors & [logger](https://pub.dev/packages/logger)
5. Managing different environments with [flutter_dotenv](https://pub.dev/packages/flutter_dotenv). Editing the `.env.dev`, `.env.preprod`, `.env.prod` files and add `.env*` to `.gitignore` file
6. Using [intl](https://pub.dev/packages/intl) to handle multiple languages (`lib/core/locales`)
   - https://plugins.jetbrains.com/plugin/13666-flutter-intl
   - https://marketplace.visualstudio.com/items?itemName=localizely.flutter-intl
7. Using [local_auth](https://pub.dev/packages/local_auth) to re-login with biometrics
8. Using [fvm](https://fvm.app/) to manage flutter versions with [sidekick](https://github.com/fluttertools/sidekick)


### Possibility of improvement
1. Replace [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) package to make key hacking harder. Instead, use the [ENVied](https://pub.dev/packages/envied) package and enable obfuscation.
   - https://codewithandrea.com/articles/flutter-api-keys-dart-define-env-files/
2. Add native splash screen with [flutter_native_splash](https://pub.dev/packages/flutter_native_splash)
3. Added accessibility with [Semantics](https://api.flutter.dev/flutter/widgets/Semantics-class.html)
   - https://blog.gskinner.com/archives/2022/09/flutter-crafting-a-great-experience-for-screen-readers.html
4. Improved l10n files (`lib/core/locales`)
5. Implementation of tests with [mockito](https://pub.dev/packages/mockito) and [alchemist](https://pub.dev/packages/alchemist)


### Useful package
1. [pigeon](https://pub.dev/packages/pigeon)


### Project structure
```lib/
├─ core/
│ ├─ constants/
│ ├─ enums/
│ ├─ impl/
│ ├─ locales/
│ ├─ providers/
│ ├─ router/
│ ├─ services/
│ ├─ usecases/
│ ├─ utils/
│ ├─ credentials.dart
├─ features/
│ ├─ commons/
│ │ ├─ pages/
│ │ ├─ widgets/
│ ├─ feature1/
│ │ ├─ data/
│ │ │ ├─ datasources/
│ │ │ ├─ models/
│ │ │ ├─ repositories/
│ │ ├─ domain/
│ │ │ ├─ entities/
│ │ │ ├─ repositories/
│ │ │ ├─ usecases/
│ │ ├─ presentation/
│ │ │ ├─ pages/
│ │ │ ├─ provider/
│ │ │ ├─ widgets/
├─ ui/
│ ├─ colors/
│ ├─ icons/
│ ├─ layout/
│ ├─ spacing/
│ ├─ themes/
│ ├─ typography/
│ ├─ widgets/
├─ app.dart
├─ main_dev.dart
├─ main_preprod.dart
├─ main_prod.dart```

### The links that helped me create this template
- [Dev Café](https://www.youtube.com/channel/UCOAErkorTQ0ZbUK9vkFyn8A)
- [Reso Coder](https://resocoder.com/)
- [Code with Andrea](https://codewithandrea.com/)
- [Flutter Mapp](https://fluttermapp.com)
- [Udemey : Flutter & Dart - The Complete Guide (2022 Edition)](https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/)
- https://github.com/rrousselGit/riverpod
- https://github.com/lucavenir/go_router_riverpod
- https://github.com/flutter/packages/tree/main/packages/go_router
- https://brickhub.dev/bricks/app_ui/0.0.4
- https://brickhub.dev/bricks/clean_architecture_folders_lib/0.1.0+2
