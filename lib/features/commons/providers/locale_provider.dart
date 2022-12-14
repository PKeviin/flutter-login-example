import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../core/constants/params_constant.dart';
import '../../../core/constants/secure_storage_constant.dart';
import '../../../core/impl/secure_storage/secure_storage_provider.dart';
import '../../../core/impl/secure_storage/secure_storage_repository.dart';
import '../../../core/locales/generated/l10n.dart';

final localeProvider = StateNotifierProvider<LocaleState, Locale>((ref) {
  final secureStorage = ref.watch(secureStorageImplProvider);
  return LocaleState(
    secureStorage: secureStorage,
  );
});

class LocaleState extends StateNotifier<Locale> {
  LocaleState({
    required this.secureStorage,
  }) : super(kFallbackLocale) {
    initLocale();
  }
  SecureStorageRepository secureStorage;

  /// Retrieval of the language used
  Future initLocale() async {
    final languageCode = await secureStorage.getItem(keyLanguageCode);
    final countryCode = await secureStorage.getItem(keyCountryCode);
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
  String get getLanguageCode => state.languageCode;

  /// Get the country code
  String? get getCountryCode => state.countryCode;

  /// Changing the language used
  Future<void> setLocale(Locale locale) async {
    state = locale;
    await secureStorage.addItem(keyLanguageCode, state.languageCode);
    await secureStorage.addItem(keyCountryCode, state.countryCode);
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
