import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/locales/generated/l10n.dart';
import '../../../core/utils/utils_validator.dart';
import '../../icons/app_icons.dart';
import '../../spacing/app_spacing.dart';

enum TextFieldType {
  email,
  password,
  name,
  address,
  other,
  phone,
  url,
  username
}

class AppTextFormField extends StatefulWidget {
  const AppTextFormField({
    required this.textFieldType,
    super.key,
    this.controller,
    this.decoration,
    this.focus,
    this.validator,
    this.isPassword,
    this.buildCounter,
    this.isValidationRequired = true,
    this.textCapitalization,
    this.textInputAction,
    this.onFieldSubmitted,
    this.nextFocus,
    this.textStyle,
    this.textAlign,
    this.maxLines,
    this.minLines,
    this.enabled,
    this.onChanged,
    this.cursorColor,
    this.suffix,
    this.suffixIconColor,
    this.enableSuggestions = true,
    this.autoFocus,
    this.readOnly = false,
    this.maxLength,
    this.keyboardType,
    this.autoFillHints,
    this.scrollPadding,
    this.onTap,
    this.cursorWidth,
    this.cursorHeight,
    this.inputFormatters,
    this.errorThisFieldRequired,
    this.errorInvalidEmail,
    this.errorInvalidPassword,
    this.errorInvalidURL,
    this.errorInvalidUsername,
    this.textAlignVertical,
    this.expands = false,
    this.showCursor,
    this.selectionControls,
    this.strutStyle,
    this.obscuringCharacter,
    this.initialValue,
    this.keyboardAppearance,
    this.toolbarOptions,
  });
  final TextEditingController? controller;
  final TextFieldType textFieldType;

  final InputDecoration? decoration;
  final FocusNode? focus;
  final FormFieldValidator<String>? validator;
  final bool? isPassword;
  final bool? isValidationRequired;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final FocusNode? nextFocus;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final int? maxLines;
  final int? minLines;
  final bool? enabled;
  final bool? autoFocus;
  final bool? readOnly;
  final bool? enableSuggestions;
  final int? maxLength;
  final Color? cursorColor;
  final Widget? suffix;
  final Color? suffixIconColor;
  final TextInputType? keyboardType;
  final Iterable<String>? autoFillHints;
  final EdgeInsets? scrollPadding;
  final double? cursorWidth;
  final double? cursorHeight;
  final Function()? onTap;
  final InputCounterWidgetBuilder? buildCounter;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlignVertical? textAlignVertical;
  final bool? expands;
  final bool? showCursor;
  final TextSelectionControls? selectionControls;
  final StrutStyle? strutStyle;
  final String? obscuringCharacter;
  final String? initialValue;
  final Brightness? keyboardAppearance;
  final ToolbarOptions? toolbarOptions;

  final String? errorThisFieldRequired;
  final String? errorInvalidEmail;
  final String? errorInvalidPassword;
  final String? errorInvalidURL;
  final String? errorInvalidUsername;

  @override
  AppTextFormFieldState createState() => AppTextFormFieldState();
}

class AppTextFormFieldState extends State<AppTextFormField> {
  bool isPasswordVisible = false;

  FormFieldValidator<String>? applyValidation() {
    if (widget.isValidationRequired!) {
      if (widget.validator != null) {
        return widget.validator;
      } else if (widget.textFieldType == TextFieldType.email) {
        return (s) {
          if (s!.trim().isEmpty) {
            return widget.errorThisFieldRequired ??
                S.current.errorThisFieldRequired;
          }
          if (!UtilsValidator.validateEmail(s.trim())) {
            return widget.errorInvalidEmail ?? S.current.errorInvalidEmail;
          }
          return null;
        };
      } else if (widget.textFieldType == TextFieldType.password) {
        return (s) {
          if (s!.trim().isEmpty) {
            return widget.errorThisFieldRequired ??
                S.current.errorThisFieldRequired;
          }
          if (!UtilsValidator.validationPassword(s.trim())) {
            return widget.errorInvalidPassword ??
                S.current.errorInvalidPassword;
          }
          return null;
        };
      } else if (widget.textFieldType == TextFieldType.name ||
          widget.textFieldType == TextFieldType.phone) {
        return (s) {
          if (s!.trim().isEmpty) {
            return widget.errorThisFieldRequired ??
                S.current.errorThisFieldRequired;
          }
          return null;
        };
      } else if (widget.textFieldType == TextFieldType.url) {
        return (s) {
          if (s!.trim().isEmpty) {
            return widget.errorThisFieldRequired ??
                S.current.errorThisFieldRequired;
          }
          if (!UtilsValidator.validationUrl(s)) {
            return widget.errorInvalidURL ?? S.current.errorInvalidURL;
          }
          return null;
        };
      } else if (widget.textFieldType == TextFieldType.username) {
        return (s) {
          if (s!.trim().isEmpty) {
            return widget.errorThisFieldRequired ??
                S.current.errorThisFieldRequired;
          }
          if (s.contains(' ')) {
            return widget.errorInvalidUsername ??
                S.current.errorInvalidUsername;
          }
          return null;
        };
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  TextCapitalization applyTextCapitalization() {
    if (widget.textCapitalization != null) {
      return widget.textCapitalization!;
    } else if (widget.textFieldType == TextFieldType.name) {
      return TextCapitalization.words;
    } else if (widget.textFieldType == TextFieldType.address) {
      return TextCapitalization.sentences;
    } else {
      return TextCapitalization.none;
    }
  }

  TextInputAction? applyTextInputAction() {
    if (widget.textInputAction != null) {
      return widget.textInputAction;
    } else if (widget.textFieldType == TextFieldType.address) {
      return TextInputAction.newline;
    } else if (widget.nextFocus != null) {
      return TextInputAction.next;
    } else {
      return TextInputAction.done;
    }
  }

  TextInputType? applyTextInputType() {
    if (widget.keyboardType != null) {
      return widget.keyboardType;
    } else if (widget.textFieldType == TextFieldType.email) {
      return TextInputType.emailAddress;
    } else if (widget.textFieldType == TextFieldType.address) {
      return TextInputType.multiline;
    } else if (widget.textFieldType == TextFieldType.password) {
      return TextInputType.visiblePassword;
    } else if (widget.textFieldType == TextFieldType.phone) {
      return TextInputType.number;
    } else if (widget.textFieldType == TextFieldType.url) {
      return TextInputType.url;
    } else {
      return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: widget.controller,
        obscureText: widget.textFieldType == TextFieldType.password &&
            !isPasswordVisible,
        validator: applyValidation(),
        textCapitalization: applyTextCapitalization(),
        textInputAction: applyTextInputAction(),
        onFieldSubmitted: (s) {
          if (widget.nextFocus != null) {
            FocusScope.of(context).requestFocus(widget.nextFocus);
          }

          if (widget.onFieldSubmitted != null) {
            widget.onFieldSubmitted!.call(s);
          }
        },
        keyboardType: applyTextInputType(),
        decoration: widget.decoration != null
            ? (widget.decoration!.copyWith(
                errorMaxLines: 3,
                suffixIcon: widget.textFieldType == TextFieldType.password
                    ? widget.suffix ??
                        InkWell(
                          child: Icon(
                            isPasswordVisible
                                ? AppIcons.visibility
                                : AppIcons.visibilityOff,
                            color: widget.suffixIconColor ??
                                Theme.of(context).iconTheme.color,
                            size: 20,
                          ),
                          onTap: () {
                            isPasswordVisible = !isPasswordVisible;
                            setState(() {});
                          },
                        )
                    : widget.suffix,
              ))
            : const InputDecoration(errorMaxLines: 3),
        focusNode: widget.focus,
        style: widget.textStyle ?? Theme.of(context).textTheme.caption,
        textAlign: widget.textAlign ?? TextAlign.start,
        maxLines: widget.textFieldType == TextFieldType.address
            ? null
            : widget.maxLines == -1
                ? null
                : widget.maxLines ?? 1,
        minLines: widget.minLines == -1 ? null : widget.minLines ?? 1,
        autofocus: widget.autoFocus ?? false,
        enabled: widget.enabled,
        onChanged: widget.onChanged,
        cursorColor: widget.cursorColor ??
            Theme.of(context).textSelectionTheme.cursorColor,
        readOnly: widget.readOnly!,
        maxLength: widget.maxLength,
        enableSuggestions: widget.enableSuggestions!,
        autofillHints: widget.autoFillHints,
        scrollPadding:
            widget.scrollPadding ?? const EdgeInsets.all(AppSpacing.xlg),
        cursorWidth: widget.cursorWidth ?? 2.0,
        cursorHeight: widget.cursorHeight,
        cursorRadius: const Radius.circular(4),
        onTap: widget.onTap,
        buildCounter: widget.buildCounter,
        scrollPhysics: const BouncingScrollPhysics(),
        enableInteractiveSelection: true,
        inputFormatters: widget.inputFormatters,
        textAlignVertical: widget.textAlignVertical,
        expands: widget.expands!,
        showCursor: widget.showCursor,
        selectionControls: widget.selectionControls,
        strutStyle: widget.strutStyle,
        obscuringCharacter: widget.obscuringCharacter ?? '•',
        initialValue: widget.initialValue,
        keyboardAppearance: widget.keyboardAppearance,
        toolbarOptions: widget.toolbarOptions,
      );
}
