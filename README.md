# Template Auth App
Authentication flutter app example for Android and iOS.  
Implementation of a clean architecture with riverpod and 180 tests (+95% code coverage without UI, provider & go_router).  
The objective of this project is to make the best use of good practices and to provide a template for a new project.

---

## đ Table of Contents

- [â¨ Demo](#demo)
- [đ Getting Started](#getting_started)
- [âšī¸ Informations](#informations)
- [đģ Commande line](#commande_line)
- [đĻ Package used](#package_used)
- [đ Translations ](#translations)
- [đ Deploying the app](#deploy)
- [đ Possibility of improvement](#improvement)
- [đĻ Useful package](#useful_package)
- [đ§ą Project structure](#project_structure)
- [đ Helped me](#helped_me)

---

<a name="demo"></a>
## â¨ Demo

![Demo](https://github.com/PKeviin/flutter-login-example/blob/master/demo.gif)

---

<a name="getting_started"></a>
## đ Getting Started 

This project contains 3 flavors:

- development
- staging
- production

Editing `.env.dev`, `.env.stg`, `.env.prod` files and add `.env*` to `.gitignore` file.

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Run Development
$ flutter run --flavor development --target lib/main_development.dart

# Run Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Run Production
$ flutter run --flavor production --target lib/main_production.dart
```

---

<a name="informations"></a>
## âšī¸ Informations

- Implementation of `FakeLoginRemoteDataSourceImpl`, Using `LoginRemoteDataSourceImpl` to implement real login
- Added a listener in the `app.dart` file to display a global failure snackbar
- Added a listener in the `app.dart` file to display a global loader overlay with [loader_overlay](https://pub.dev/packages/loader_overlay)
- Implementation of `privacy_provider.dart` to manage user's privacy status
- Saving user in phone, Using [local_auth](https://pub.dev/packages/local_auth) to re-login with biometrics

---

<a name="commande_line"></a>
## đģ Commande line

### Build runner for [freezed](https://pub.dev/packages/freezed) and [json_serializable](https://pub.dev/packages/json_serializable)
`flutter pub run build_runner build --delete-conflicting-outputs`

### [Splash screen](https://pub.dev/packages/flutter_native_splash)
```shell
flutter pub run flutter_native_splash:create --path=flutter_native_splash.yaml
flutter pub run flutter_native_splash:remove
```


### [Launcher Icons](https://pub.dev/packages/flutter_launcher_icons)
Generation of icons for the different flavors for Android and iOS

```shell
# Production
flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons-production.yaml

# Staging
flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons-staging.yaml

# Development
flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons-development.yaml
```

### Test coverage [More detail here](https://www.etiennetheodore.com/test-coverage-explain-with-lcov-on-dart/)
```shell
sh scripts/import_files_coverage.sh template
sh scripts/create_clean_lcov_and_generate_html.sh true
```

---

<a name="package_used"></a>
## đĻ Package used

- [Riverpod](https://pub.dev/packages/flutter_riverpod) implementation for state-management
- Using [go_router](https://pub.dev/packages/go_router) and `ChangeNotifier` to handle redirects
- [Wiredash](https://pub.dev/packages/wiredash) implementation in `app.dart` file to manage feedbacks
- Implemented [sentry_flutter](https://pub.dev/packages/sentry_flutter) in `main_prepod.dart` and `main_prod.dart` to capture errors & [logger](https://pub.dev/packages/logger)
- Managing different environments with [flutter_dotenv](https://pub.dev/packages/flutter_dotenv). Editing the `.env.dev`, `.env.stg`, `.env.prod` files and add `.env*` to `.gitignore` file
- Using [intl](https://pub.dev/packages/intl) to handle multiple languages (`lib/core/locales`)
   - https://plugins.jetbrains.com/plugin/13666-flutter-intl
   - https://marketplace.visualstudio.com/items?itemName=localizely.flutter-intl
- Using [local_auth](https://pub.dev/packages/local_auth) to re-login with biometrics
- Using [fvm](https://fvm.app/) to manage flutter versions with [sidekick](https://github.com/fluttertools/sidekick)
- Using [mocktail](https://pub.dev/packages/mocktail) for tests

---

<a name="translations"></a>
## đ Translations 

This project relies on [flutter_localizations][https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html] with [Flutter Intl](https://plugins.jetbrains.com/plugin/13666-flutter-intl).

### Adding Strings
1. To add a new localizable string, open the `intl_en.arb` and all other `.arb` file at `lib/core/lcoales/l10n/`.

```arb
{
    "helloWorld": "Hello World!",
    "@helloWorld": {
      "description": "The conventional newborn programmer greeting"
    }
}
```

2. Use the new string

````dart
import 'lib/core/locales/generated/l10n.dart';

// If you don't have `context` to pass
@override
Widget build(BuildContext context) {
   return Text(S.current.helloWorld);
}

// With context
@override
Widget build(BuildContext context) {
   return Text(S.of(context).helloWorld);
}
````

### Adding Supported Locales
Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Adding Translations
For each supported locale, add a new ARB file in `lib/core/locales/l10n`.

```
âââ core
â   âââlocales
â   â  âââ l10n
â   â  â   âââ app_en.arb
â   â  â   âââ app_es.arb
```

---

<a name="deploy"></a>
## đ Deploying the app

### đ  Prerequisites
- Code Signin Assets
   - đ Apple Certificate
      - public key (download from the developer.apple.com console)
      - private key (.p12)
   - đ¤ Android Keystore
      - `key.properties` file -> to store at: `app/android/key.properties`
      - `android_key.keystore` file -> to store at: `app/android/app/android_key.keystore`

### đˇ Bump the app version
In `pubspec.yaml`:
``` yaml
version: 0.0.1+1 # {version}+{build} Bump version following semantic version rules, and bump build ALWAYS (for each new release)
```
commit and push to `master` branch  
commit and push tag `v{version} (v0.0.1)` to `master` branch

### đĻ Building apps for the stores
- đ iOS : `flutter build ios --flavor production --target lib/main_prod.dart --release`
- đ¤ Android : `flutter build appbundl --flavor production --target lib/main_prod.dart --release`

### đ Upload to stores

##### đ iOS
Upload the build to App Store Connect using the [Transporter App](https://apps.apple.com/us/app/transporter/id1450874784)  
Go to the App Store Connect console: https://appstoreconnect.apple.com/apps/

###### âī¸ TestFlight
- âŗ Wait for the build to be available for testing
- đ Submit for review
- đ§Ē Submit to Internal or External testers

###### â App Store (Production)
- đ Create a new version
- đĻ Select the latest build
- đ Submit for review
- đ˛ Submit to users

##### đ¤ Android
Go to Google Play console: https://play.google.com/console/u/0/developers/

###### âī¸ Tests Internes
- đ Create a Release
- đĻ Uploader the build
- đ§Ē Submit to testers

###### â Production
- đ Create a Release
- đĻ Uploader the build
- đ˛ Submit to users

---

<a name="improvement"></a>
## đ Possibility of improvement

1. Replace [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) package to make key hacking harder. Instead, use the [ENVied](https://pub.dev/packages/envied) package and enable obfuscation.
   - https://codewithandrea.com/articles/flutter-api-keys-dart-define-env-files/
2. Added accessibility with [Semantics](https://api.flutter.dev/flutter/widgets/Semantics-class.html)
   - https://blog.gskinner.com/archives/2022/09/flutter-crafting-a-great-experience-for-screen-readers.html
3. Implementation widget test, provider test, go_router test and integration tests

---

<a name="useful_package"></a>
## đĻ Useful package

- [pigeon](https://pub.dev/packages/pigeon)
- [alchemist](https://pub.dev/packages/alchemist)

---

<a name="project_structure"></a>
## đ§ą Project structure

```
lib/
ââ core/
â ââ credentials.dart
â ââ constants/
â ââ enums/
â ââ impl/
â â ââ api/
â â ââ local_auth/
â â ââ logger/
â â ââ network_info/
â â ââ package_info/
â â ââ picker_file/
â â ââ secure_storage/
â â ââ share_file/
â ââ locales/
â ââ router/
â ââ utils/
â â ââ errors/
â â ââ extensions/
â â ââ platform/
â â ââ usecases/
â â ââ utils.dart
â â ââ utils_ui.dart
â â ââ utils_validator.dart
ââ features/
â ââ commons/
â â ââ pages/
â â ââ providers/
â â ââ widgets/
â ââ feature1/
â â ââ data/
â â â ââ datasources/
â â â ââ models/
â â â ââ repositories/
â â ââ domain/
â â â ââ entities/
â â â ââ repositories/
â â â ââ usecases/
â â ââ presentation/
â â â ââ pages/
â â â ââ provider/
â â â ââ widgets/
ââ ui/
â ââ assets/
â ââ colors/
â ââ icons/
â ââ layout/
â ââ spacing/
â ââ themes/
â ââ typography/
â ââ widgets/
ââ app.dart
ââ main_dev.dart
ââ main_preprod.dart
ââ main_prod.dart
test/
```

---

<a name="helped_me"></a>
## đ Helped me

The links that helped me create this template

- [Dev CafÃŠ](https://www.youtube.com/channel/UCOAErkorTQ0ZbUK9vkFyn8A)
- [Reso Coder](https://resocoder.com/)
- [Code with Andrea](https://codewithandrea.com/)
- [Flutter Mapp](https://fluttermapp.com)
- [Udemey : Flutter & Dart - The Complete Guide (2022 Edition)](https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/)
- [Flavors Android & iOS](https://medium.com/@animeshjain/build-flavors-in-flutter-android-and-ios-with-different-firebase-projects-per-flavor-27c5c5dac10b)
- https://github.com/rrousselGit/riverpod
- https://github.com/lucavenir/go_router_riverpod
- https://github.com/flutter/packages/tree/main/packages/go_router
- https://brickhub.dev/bricks/app_ui/0.0.4
- https://brickhub.dev/bricks/clean_architecture_folders_lib/0.1.0+2
- https://github.com/gskinnerTeam/flutter-wonderous-app
- https://betterprogramming.pub/flutter-unit-testing-the-beginners-guide-35105164722e#22c2