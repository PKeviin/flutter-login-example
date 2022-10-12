import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/locales/generated/l10n.dart';
import '../../../../core/router/routes.dart';
import '../../../../ui/icons/app_icons.dart';
import '../../../../ui/widgets/circular_indicator.dart';
import '../../../../ui/widgets/decorations/app_input_decoration.dart';
import '../../../../ui/widgets/fields/app_text_form_field.dart';
import '../provider/login_provider.dart';
import '../provider/user_has_already_logged_in_provider.dart';
import 'login_button_widget.dart';
import 'reconnect_widget.dart';

class BodyFieldWidget extends ConsumerStatefulWidget {
  const BodyFieldWidget({super.key});

  @override
  BodyFieldWidgetState createState() => BodyFieldWidgetState();
}

class BodyFieldWidgetState extends ConsumerState<BodyFieldWidget> {
  final FocusNode _identifiantFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final userHasAlreadyLoggedIn = ref.watch(userHasAlreadyLoggedInProvider);
    final identifiant = ref.watch(identifiantProvider);
    final password = ref.watch(passwordProvider);
    return Column(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.current.loginEmail,
              style: Theme.of(context).textTheme.caption,
            ),
            const SizedBox(height: 8),
            AppTextFormField(
              decoration: AppDecorations.customInputDecoration(
                context: context,
                hint: S.current.loginEmailField,
                prefixIcon: AppIcons.accountCircleOutlined,
                size: 20,
              ),
              onChanged: (value) =>
                  ref.read(identifiantProvider.notifier).state = value,
              textFieldType: TextFieldType.name,
              keyboardType: TextInputType.name,
              focus: _identifiantFocusNode,
              nextFocus: _passwordFocusNode,
            ),
            const SizedBox(height: 16),
            Text(
              S.current.loginPassword,
              style: Theme.of(context).textTheme.caption,
            ),
            const SizedBox(height: 8),
            AppTextFormField(
              decoration: AppDecorations.customInputDecoration(
                context: context,
                hint: S.current.loginPasswordField,
                prefixIcon: AppIcons.lockOutline,
                size: 20,
              ),
              onChanged: (value) =>
                  ref.read(passwordProvider.notifier).state = value,
              suffixIconColor: Theme.of(context).colorScheme.primary,
              textFieldType: TextFieldType.password,
              isPassword: true,
              keyboardType: TextInputType.visiblePassword,
              focus: _passwordFocusNode,
              onFieldSubmitted: (value) async {
                if (identifiant.isNotEmpty && password.isNotEmpty) {
                  await ref
                      .read(loginProvider.notifier)
                      .eitherFailureOrLoginUser(
                        identifiant,
                        password,
                      );
                }
              },
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                child: Text(
                  S.current.loginForgetPassword,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                onPressed: () =>
                    context.push(AppRoutes.forgetPassword.routePath),
              ),
            ),
            const SizedBox(height: 30),
            userHasAlreadyLoggedIn.when(
              data: (data) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const LoginButtonWidget(),
                  if (data) ...[
                    const SizedBox(width: 20),
                    const ReconnectBiometricButtonWidget(),
                  ]
                ],
              ),
              error: (err, stack) => const LoginButtonWidget(),
              loading: () => const Center(child: CircularIndicator()),
            ),
          ],
        )
      ],
    );
  }
}
