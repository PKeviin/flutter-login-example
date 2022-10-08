import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/locales/generated/l10n.dart';
import '../../../../ui/colors/app_colors.dart';
import '../../../../ui/spacing/app_spacing.dart';
import '../../../../ui/widgets/buttons/app_rounded_button.dart';

class ErrorConnectionPage extends StatelessWidget {
  const ErrorConnectionPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            Image.asset(
              'assets/images/errors/error_connection.png',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.sm,
                horizontal: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${S.current.errorNoConnection}!',
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: AppColors.black),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    S.current.errorNoConnectionMessage,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: AppColors.black),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 32),
                  AppRoundedButton(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    onTap: () => context.go('/'),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                      child: Text(
                        S.current.home.toUpperCase(),
                        style: const TextStyle(color: AppColors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      );
}
