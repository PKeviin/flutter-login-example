import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/locales/generated/l10n.dart';
import '../../../../core/router/routes.dart';
import '../../../../ui/colors/app_colors.dart';
import '../../../../ui/icons/app_icons.dart';
import '../../../../ui/widgets/buttons/app_rounded_button.dart';
import '../../../../ui/widgets/decorations/app_input_decoration.dart';
import '../../../../ui/widgets/fields/app_text_form_field.dart';
import '../provider/user_provider.dart';

class BodyFieldWidget extends ConsumerStatefulWidget {
  const BodyFieldWidget({super.key});

  @override
  BodyFieldWidgetState createState() => BodyFieldWidgetState();
}

class BodyFieldWidgetState extends ConsumerState<BodyFieldWidget> {
  final _identifiantController = TextEditingController();
  final _passwordController = TextEditingController();
  final FocusNode _identifiantFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) => Column(
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
                onChanged: (value) => setState(() {}),
                textFieldType: TextFieldType.name,
                keyboardType: TextInputType.name,
                controller: _identifiantController,
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
                onChanged: (value) => setState(() {}),
                suffixIconColor: Theme.of(context).colorScheme.primary,
                textFieldType: TextFieldType.password,
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordController,
                focus: _passwordFocusNode,
                onFieldSubmitted: (value) async {
                  if (_identifiantController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty) {
                    await ref
                        .read(userProvider.notifier)
                        .eitherFailureOrLoginUser(
                          _identifiantController.text,
                          _passwordController.text,
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
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                ),
                child: AppRoundedButton(
                  text: S.current.login,
                  color: _identifiantController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty
                      ? AppColors.primary
                      : AppColors.gray,
                  disabled: _identifiantController.text.isEmpty ||
                      _passwordController.text.isEmpty,
                  textColor: _identifiantController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty
                      ? AppColors.white
                      : AppColors.black,
                  width: MediaQuery.of(context).size.width,
                  onTap: () async =>
                      ref.read(userProvider.notifier).eitherFailureOrLoginUser(
                            _identifiantController.text,
                            _passwordController.text,
                          ),
                ),
              ),
            ],
          )
        ],
      );
}
