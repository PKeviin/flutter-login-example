import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../constants/params_constant.dart';
import '../constants/secure_storage_constant.dart';
import '../impl/secure_storage_impl.dart';
import '../locales/generated/l10n.dart';

final localeProvider = StateNotifierProvider<LocaleState, Locale>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return LocaleState(
    secureStorageImpl: secureStorage,
  );
});

abstract class LocaleRepository {
  String get getLanguageCode;
  String? get getCountryCode;
  void setLocale(Locale locale);
}

class LocaleState extends StateNotifier<Locale> implements LocaleRepository {
  LocaleState({
    required this.secureStorageImpl,
  }) : super(kFallbackLocale) {
    unawaited(_initLocale());
  }
  SecureStorageImpl secureStorageImpl;

  /// Retrieval of the language used
  Future _initLocale() async {
    final languageCode = await secureStorageImpl.getItem(keyLanguageCode);
    final countryCode = await secureStorageImpl.getItem(keyCountryCode);
    if (languageCode != null) {
      state = Locale(languageCode, countryCode);
    } else {
      final deviceLocale = Locale(Intl.getCurrentLocale());
      if (S.delegate.supportedLocales.contains(deviceLocale)) {
        state = deviceLocale;
      } else {
        state = kFallbackLocale;
      }
    }
    _initLocalTimeAgo();
    _setLocalTimeAgo();
    debugPrint('language [${state.languageCode}]');
  }

  /// Get the language code
  @override
  String get getLanguageCode => state.languageCode;

  /// Get the country code
  @override
  String? get getCountryCode => state.countryCode;

  /// Changing the language used
  @override
  Future<void> setLocale(Locale locale) async {
    state = locale;
    await secureStorageImpl.addItem(keyLanguageCode, state.languageCode);
    await secureStorageImpl.addItem(keyCountryCode, state.countryCode);
    _setLocalTimeAgo();
  }

  /// Init timeago translations
  void _initLocalTimeAgo() {
    timeago.setLocaleMessages('fr', timeago.FrMessages());
    timeago.setLocaleMessages('en', timeago.EnMessages());
  }

  /// Added timeago translations
  void _setLocalTimeAgo() => timeago.setDefaultLocale(state.languageCode);
}
