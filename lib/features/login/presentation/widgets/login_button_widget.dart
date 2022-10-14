import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/locales/generated/l10n.dart';
import '../../../../ui/colors/app_colors.dart';
import '../../../../ui/widgets/buttons/app_rounded_button.dart';
import '../provider/login_provider.dart';

class LoginButtonWidget extends ConsumerWidget {
  const LoginButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username = ref.watch(usernameProvider);
    final password = ref.watch(passwordProvider);

    return AppRoundedButton(
      text: S.current.login,
      color: username.isNotEmpty && password.isNotEmpty
          ? AppColors.primary
          : AppColors.gray,
      disabled: username.isEmpty || password.isEmpty,
      textColor: username.isNotEmpty && password.isNotEmpty
          ? AppColors.white
          : AppColors.black,
      width: MediaQuery.of(context).size.width / 1.5,
      onTap: () async =>
          ref.read(loginProvider.notifier).eitherFailureOrLoginUser(
                username,
                password,
              ),
    );
  }
}
