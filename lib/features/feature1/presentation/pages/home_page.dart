import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enums/privacy_status_enum.dart';
import '../../../../core/locales/generated/l10n.dart';
import '../../../../core/providers/privacy_provider.dart';
import '../../../../ui/colors/app_colors.dart';
import '../../../../ui/widgets/buttons/app_rounded_button.dart';
import '../../../../ui/widgets/dialogs/simple_question_dialog.dart';
import '../../../login/presentation/provider/login_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _listenPrivacyStatus(ref, context);
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Page'),
            const SizedBox(height: 50),
            SizedBox(
              width: 200,
              child: AppRoundedButton(
                text: S.current.logout,
                color: AppColors.primary,
                textColor: AppColors.white,
                width: MediaQuery.of(context).size.width,
                onTap: () async => ref
                    .read(loginProvider.notifier)
                    .eitherFailureOrLogoutUser(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Listening to privacy status
  /// Display a dialog if privacy is not selected
  /// [WidgetRef] ref
  void _listenPrivacyStatus(WidgetRef ref, BuildContext context) {
    ref.listen<PrivacyStatusEnum?>(privacyProvider, (oldPrivacy, newPrivacy) {
      if (newPrivacy != null) {
        switch (newPrivacy) {
          case PrivacyStatusEnum.authorized:
          case PrivacyStatusEnum.denied:
          case PrivacyStatusEnum.unknown:
            // No action
            break;
          case PrivacyStatusEnum.requested:
            Future.delayed(const Duration(seconds: 2), () async {
              await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => SimpleQuestionDialog(
                  descriptionText: S.current.permissionQuestion,
                  allowCallBack: () => ref
                      .read(privacyProvider.notifier)
                      .setPrivacy(PrivacyStatusEnum.authorized),
                  denyCallBack: () => ref
                      .read(privacyProvider.notifier)
                      .setPrivacy(PrivacyStatusEnum.denied),
                ),
              );
            });
            break;
        }
      }
    });
  }
}
