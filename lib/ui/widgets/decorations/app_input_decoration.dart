import 'package:flutter/material.dart';
import '../../spacing/app_spacing.dart';

class AppDecorations {
  static InputDecoration customInputDecoration({
    required BuildContext context,
    IconData? prefixIcon,
    double? size,
    String? labelText,
    String? hint,
    Color? bgColor,
    Color? borderColor,
    EdgeInsets? padding,
  }) =>
      InputDecoration(
        labelText: labelText,
        contentPadding: padding ??
            const EdgeInsets.symmetric(
              vertical: AppSpacing.lg,
              horizontal: AppSpacing.lg,
            ),
        counter: const Offstage(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: borderColor ?? Theme.of(context).colorScheme.primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
        ),
        fillColor: bgColor ?? Colors.transparent,
        hintText: hint,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: Theme.of(context).colorScheme.primary,
                size: size,
              )
            : null,
        hintStyle: Theme.of(context).textTheme.caption,
        filled: true,
      );
}
