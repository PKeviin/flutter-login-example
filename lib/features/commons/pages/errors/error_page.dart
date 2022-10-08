import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/locales/generated/l10n.dart';
import '../../../../ui/colors/app_colors.dart';
import '../../../../ui/spacing/app_spacing.dart';
import '../../../../ui/widgets/buttons/app_rounded_button.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage(
    this.error, {
    super.key,
  });
  final Exception? error;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            Image.asset(
              'assets/images/errors/error.png',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${S.current.labelError}!',
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: AppColors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.sm,
                    horizontal: 40,
                  ),
                  child: Text(
                    error.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: AppColors.black),
                    textAlign: TextAlign.center,
                  ),
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
          ],
        ),
      );
}