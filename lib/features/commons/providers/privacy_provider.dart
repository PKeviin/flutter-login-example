import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/secure_storage_constant.dart';
import '../../../core/enums/privacy_status_enum.dart';
import '../../../core/impl/secure_storage/secure_storage_provider.dart';
import '../../../core/impl/secure_storage/secure_storage_repository.dart';
import '../../../core/utils/extensions/string_extension.dart';

final privacyProvider =
    StateNotifierProvider<PrivacyState, PrivacyStatusEnum>((ref) {
  final secureStorage = ref.watch(secureStorageImplProvider);
  return PrivacyState(
    secureStorage: secureStorage,
  );
});

class PrivacyState extends StateNotifier<PrivacyStatusEnum> {
  PrivacyState({
    required this.secureStorage,
  }) : super(PrivacyStatusEnum.unknown) {
    initStatusPrivacy();
  }
  SecureStorageRepository secureStorage;

  /// Init privacy status Check
  Future<void> initStatusPrivacy() async {
    final store = await secureStorage.getItem(keyPrivacy);
    if (store.isNotNullOrEmpty()) {
      state = store == PrivacyStatusEnum.authorized.name
          ? PrivacyStatusEnum.authorized
          : PrivacyStatusEnum.denied;
    } else {
      state = PrivacyStatusEnum.requested;
    }
    debugPrint('privacy [${state.name}]');
  }

  /// Changing the privacy
  Future<void> setPrivacy(PrivacyStatusEnum privacy) async {
    state = privacy;
    await secureStorage.addItem(keyPrivacy, state.name);
    debugPrint('privacy [${state.name}]');
  }
}
