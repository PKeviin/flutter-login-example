import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/locales/generated/l10n.dart';
import '../../colors/app_colors.dart';
import '../../spacing/app_spacing.dart';

class SimpleQuestionDialog extends StatelessWidget {
  const SimpleQuestionDialog({
    required this.descriptionText,
    required this.allowCallBack,
    this.allowTextButton,
    this.denyTextButton,
    this.denyCallBack,
    super.key,
  });
  final String descriptionText;
  final String? allowTextButton;
  final String? denyTextButton;
  final Function() allowCallBack;
  final Function()? denyCallBack;

  @override
  Widget build(BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.lg),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: _content(context),
      );

  Widget _content(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSpacing.sm),
          boxShadow: const [
            BoxShadow(
              color: AppColors.charcoal,
              blurRadius: 10,
              offset: Offset(0, 10),
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(AppSpacing.xlg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AutoSizeText(
              descriptionText,
              maxLines: 3,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: AppSpacing.xxlg),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    allowCallBack();
                  },
                  child: Text(allowTextButton ?? S.current.allow),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    denyCallBack?.call();
                  },
                  child: Text(denyTextButton ?? S.current.deny),
                ),
              ],
            ),
          ],
        ),
      );
}
