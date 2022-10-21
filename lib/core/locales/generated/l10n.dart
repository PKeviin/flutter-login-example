// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sucess`
  String get labelSucces {
    return Intl.message(
      'Sucess',
      name: 'labelSucces',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get labelError {
    return Intl.message(
      'Error',
      name: 'labelError',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get themeLight {
    return Intl.message(
      'Light',
      name: 'themeLight',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get themeDark {
    return Intl.message(
      'Dark',
      name: 'themeDark',
      desc: '',
      args: [],
    );
  }

  /// `We need your permission to collect data.`
  String get permissionQuestion {
    return Intl.message(
      'We need your permission to collect data.',
      name: 'permissionQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Allow`
  String get allow {
    return Intl.message(
      'Allow',
      name: 'allow',
      desc: '',
      args: [],
    );
  }

  /// `Deny`
  String get deny {
    return Intl.message(
      'Deny',
      name: 'deny',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get loginHello {
    return Intl.message(
      'Hello',
      name: 'loginHello',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get loginEmail {
    return Intl.message(
      'Email',
      name: 'loginEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get loginPassword {
    return Intl.message(
      'Password',
      name: 'loginPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get loginEmailField {
    return Intl.message(
      'Enter your email',
      name: 'loginEmailField',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get loginPasswordField {
    return Intl.message(
      'Enter your password',
      name: 'loginPasswordField',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get loginSignInButton {
    return Intl.message(
      'Sign in',
      name: 'loginSignInButton',
      desc: '',
      args: [],
    );
  }

  /// `Save password`
  String get loginSavePassword {
    return Intl.message(
      'Save password',
      name: 'loginSavePassword',
      desc: '',
      args: [],
    );
  }

  /// `Forget password ?`
  String get loginForgetPassword {
    return Intl.message(
      'Forget password ?',
      name: 'loginForgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `You do not have an account ?`
  String get loginNoAccount {
    return Intl.message(
      'You do not have an account ?',
      name: 'loginNoAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get loginCreateAnAccount {
    return Intl.message(
      'Sign up',
      name: 'loginCreateAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get login {
    return Intl.message(
      'Sign in',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Try Again.`
  String get errorMessage {
    return Intl.message(
      'Try Again.',
      name: 'errorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Page Not Found`
  String get errorPageNotFound {
    return Intl.message(
      'Page Not Found',
      name: 'errorPageNotFound',
      desc: '',
      args: [],
    );
  }

  /// `The page you are looking for doesn't seem to exist...`
  String get errorPageNotFoundMessage {
    return Intl.message(
      'The page you are looking for doesn\'t seem to exist...',
      name: 'errorPageNotFoundMessage',
      desc: '',
      args: [],
    );
  }

  /// `Connection Failed`
  String get errorNoConnection {
    return Intl.message(
      'Connection Failed',
      name: 'errorNoConnection',
      desc: '',
      args: [],
    );
  }

  /// `Could not connect to the network,\nPlease check and retry again.`
  String get errorNoConnectionMessage {
    return Intl.message(
      'Could not connect to the network,\nPlease check and retry again.',
      name: 'errorNoConnectionMessage',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong.`
  String get errorSomethingWentWrong {
    return Intl.message(
      'Something went wrong.',
      name: 'errorSomethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet connection.`
  String get errorInternetConnection {
    return Intl.message(
      'Please check your internet connection.',
      name: 'errorInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `This field is required.`
  String get errorThisFieldRequired {
    return Intl.message(
      'This field is required.',
      name: 'errorThisFieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `Your internet is not working.`
  String get errorInternetNotAvailable {
    return Intl.message(
      'Your internet is not working.',
      name: 'errorInternetNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Email is invalid.`
  String get errorInvalidEmail {
    return Intl.message(
      'Email is invalid.',
      name: 'errorInvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `The password must be between 8 and 32 characters.`
  String get errorInvalidPassword {
    return Intl.message(
      'The password must be between 8 and 32 characters.',
      name: 'errorInvalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Invalid password.`
  String get errorPassEmpty {
    return Intl.message(
      'Invalid password.',
      name: 'errorPassEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Username must not contain spaces.`
  String get errorInvalidUsername {
    return Intl.message(
      'Username must not contain spaces.',
      name: 'errorInvalidUsername',
      desc: '',
      args: [],
    );
  }

  /// `Invalid URL.`
  String get errorInvalidURL {
    return Intl.message(
      'Invalid URL.',
      name: 'errorInvalidURL',
      desc: '',
      args: [],
    );
  }

  /// `Invalid request.`
  String get errorBadRequestApi {
    return Intl.message(
      'Invalid request.',
      name: 'errorBadRequestApi',
      desc: '',
      args: [],
    );
  }

  /// `Your session has expired.`
  String get errorSessionExpireApi {
    return Intl.message(
      'Your session has expired.',
      name: 'errorSessionExpireApi',
      desc: '',
      args: [],
    );
  }

  /// `You are not authorized to access this content. Please log in again.`
  String get errorApiUnauthorized {
    return Intl.message(
      'You are not authorized to access this content. Please log in again.',
      name: 'errorApiUnauthorized',
      desc: '',
      args: [],
    );
  }

  /// `Not found.`
  String get errorApiNotFound {
    return Intl.message(
      'Not found.',
      name: 'errorApiNotFound',
      desc: '',
      args: [],
    );
  }

  /// `An error has occurred.`
  String get errorApi {
    return Intl.message(
      'An error has occurred.',
      name: 'errorApi',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while retrieving the token.`
  String get errorFormatToken {
    return Intl.message(
      'An error occurred while retrieving the token.',
      name: 'errorFormatToken',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while retrieving data.`
  String get errorDataApi {
    return Intl.message(
      'An error occurred while retrieving data.',
      name: 'errorDataApi',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while communicating with the server.`
  String get errorServerApi {
    return Intl.message(
      'An error occurred while communicating with the server.',
      name: 'errorServerApi',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while verifying the certificate. Try Again.`
  String get errorVerificationCertificatApi {
    return Intl.message(
      'An error occurred while verifying the certificate. Try Again.',
      name: 'errorVerificationCertificatApi',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while setting up a secure connection to the server. Try Again.`
  String get errorCertificatServerApi {
    return Intl.message(
      'An error occurred while setting up a secure connection to the server. Try Again.',
      name: 'errorCertificatServerApi',
      desc: '',
      args: [],
    );
  }

  /// `Error retrieving user from cache.`
  String get errorRetrievingUserCache {
    return Intl.message(
      'Error retrieving user from cache.',
      name: 'errorRetrievingUserCache',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save user in cache.`
  String get errorSaveUserCache {
    return Intl.message(
      'Failed to save user in cache.',
      name: 'errorSaveUserCache',
      desc: '',
      args: [],
    );
  }

  /// `Biometric verification did not work.`
  String get errorBiometrics {
    return Intl.message(
      'Biometric verification did not work.',
      name: 'errorBiometrics',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
