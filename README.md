# Template
Authentication flutter app example for Android and iOS.  
Implementation of a clean architecture with riverpod and +180 tests (95% code coverage without UI, provider & go_router).  
The objective of this project is to make the best use of good practices and to provide a template for a new project.

### Getting Started
Editing `.env.dev`, `.env.preprod`, `.env.prod` files and add `.env*` to `.gitignore` file.  
Run `main_dev.dart`, `main_preprod.dart`, `main_prod.dart`

### Commande line
##### Build release
iOS : `flutter build ios -t lib/main_prod.dart --release`  
Android : `flutter build appbundle -t lib/main_prod.dart --release`

##### Build runner for [freezed](https://pub.dev/packages/freezed) and [json_serializable](https://pub.dev/packages/json_serializable)
`flutter pub run build_runner build --delete-conflicting-outputs`

#### [Splash screen](https://pub.dev/packages/flutter_native_splash)
`flutter pub run flutter_native_splash:create --path=flutter_native_splash.yaml`  
`flutter pub run flutter_native_splash:remove`

#### [Launcher Icons](https://pub.dev/packages/flutter_launcher_icons)
`flutter pub run flutter_launcher_icons:main -f flutter_launcher_icon.yaml`

#### Test coverage [More detail here](https://www.etiennetheodore.com/test-coverage-explain-with-lcov-on-dart/)
```
sh scripts/import_files_coverage.sh template
sh scripts/create_clean_lcov_and_generate_html.sh true
```


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
9. Using [mocktail](https://pub.dev/packages/mocktail) for tests

### Possibility of improvement
1. Replace [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) package to make key hacking harder. Instead, use the [ENVied](https://pub.dev/packages/envied) package and enable obfuscation.
   - https://codewithandrea.com/articles/flutter-api-keys-dart-define-env-files/
2. Added accessibility with [Semantics](https://api.flutter.dev/flutter/widgets/Semantics-class.html)
   - https://blog.gskinner.com/archives/2022/09/flutter-crafting-a-great-experience-for-screen-readers.html
3. Implementation widget test, provider test, go_router test and integration tests

### Useful package
1. [pigeon](https://pub.dev/packages/pigeon)
2. [alchemist](https://pub.dev/packages/alchemist)


### Project structure
```
lib/
├─ core/
│ ├─ credentials.dart
│ ├─ constants/
│ ├─ enums/
│ ├─ impl/
│ │ ├─ api/
│ │ ├─ local_auth/
│ │ ├─ logger/
│ │ ├─ network_info/
│ │ ├─ package_info/
│ │ ├─ picker_file/
│ │ ├─ secure_storage/
│ │ ├─ share_file/
│ ├─ locales/
│ ├─ router/
│ ├─ utils/
│ │ ├─ errors/
│ │ ├─ extensions/
│ │ ├─ platform/
│ │ ├─ usecases/
│ │ ├─ utils.dart
│ │ ├─ utils_ui.dart
│ │ ├─ utils_validator.dart
├─ features/
│ ├─ commons/
│ │ ├─ pages/
│ │ ├─ providers/
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
│ ├─ assets/
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
├─ main_prod.dart
test/
```

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
- https://github.com/gskinnerTeam/flutter-wonderous-app