import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../ui/assets/app_assets.dart';
import '../../../../ui/colors/app_colors.dart';
import '../providers/login_provider.dart';
import '../providers/user_has_already_logged_in_provider.dart';

class ReconnectBiometricButtonWidget extends ConsumerWidget {
  const ReconnectBiometricButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userHasAlreadyLoggedIn = ref.watch(userHasAlreadyLoggedInProvider);
    return userHasAlreadyLoggedIn.when(
      data: (data) => Visibility(
        visible: data,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Center(
            child: GestureDetector(
              child: SvgPicture.asset(
                AppSvgPaths.fingerprint,
                width: 50,
                height: 50,
                color: AppColors.darkGray,
              ),
              onTap: () async => ref
                  .read(loginProvider.notifier)
                  .eitherFailureOrLoginLocaleUser(),
            ),
          ),
        ),
      ),
      error: (err, stack) => const SizedBox(),
      loading: () => const SizedBox(),
    );
  }
}
