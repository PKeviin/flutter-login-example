import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wiredash/wiredash.dart';

import '../../../../core/locales/generated/l10n.dart';
import '../../../../core/router/routes.dart';
import '../../../../ui/colors/app_colors.dart';
import '../../../../ui/icons/app_icons.dart';
import '../../../../ui/spacing/app_spacing.dart';
import '../../../commons/widgets/lang_picker.dart';
import '../../../commons/widgets/theme_switch.dart';
import '../widgets/body_field_widget.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: AppBar(
          actions: const [
            ThemeSwitch(),
            SizedBox(width: 10),
            LangPicker(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Wiredash.of(context).show(inheritMaterialTheme: true),
          child: const Icon(AppIcons.feedbackOutlined, color: AppColors.white),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    AutoSizeText(
                      S.current.loginHello,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(height: 40),
                    const BodyFieldWidget(),
                    const SizedBox(height: 30),
                    Center(
                      child: TextButton(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              S.current.loginNoAccount,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              S.current.loginCreateAnAccount,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        onPressed: () =>
                            context.push(AppRoutes.signup.routePath),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
