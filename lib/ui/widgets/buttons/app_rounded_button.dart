import 'package:flutter/material.dart';
import '../../colors/app_colors.dart';
import '../../spacing/app_spacing.dart';

class AppRoundedButton extends StatefulWidget {
  const AppRoundedButton({
    super.key,
    this.onTap,
    this.text,
    this.width,
    this.color,
    this.textColor,
    this.padding,
    this.margin,
    this.textStyle,
    this.shapeBorder,
    this.child,
    this.elevation,
    this.enabled = true,
    this.height,
    this.disabledColor,
    this.disabled = false,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
    this.enableScaleAnimation = true,
  });
  final Function? onTap;
  final String? text;
  final double? width;
  final Color? color;
  final Color? textColor;
  final bool? disabled;
  final Color? disabledColor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? splashColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final TextStyle? textStyle;
  final ShapeBorder? shapeBorder;
  final Widget? child;
  final double? elevation;
  final double? height;
  final bool? enabled;
  final bool? enableScaleAnimation;

  @override
  AppRoundedButtonState createState() => AppRoundedButtonState();
}

class AppRoundedButtonState extends State<AppRoundedButton>
    with SingleTickerProviderStateMixin {
  double _scale = 1;
  AnimationController? _controller;

  @override
  void initState() {
    if (widget.enableScaleAnimation! && !widget.disabled!) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 50),
        upperBound: 0.1,
      )..addListener(() {
          setState(() {});
        });
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller != null) {
      _scale = 1 - _controller!.value;
    }

    if (widget.enableScaleAnimation!) {
      return Listener(
        onPointerDown: (details) {
          _controller?.forward();
        },
        onPointerUp: (details) {
          _controller?.reverse();
        },
        child: Transform.scale(
          scale: _scale,
          child: buildButton(),
        ),
      );
    } else {
      return buildButton();
    }
  }

  Widget buildButton() => AbsorbPointer(
        absorbing: widget.disabled!,
        child: Padding(
          padding: widget.margin ?? EdgeInsets.zero,
          child: MaterialButton(
            minWidth: widget.width,
            padding: widget.padding ??
                const EdgeInsets.symmetric(
                  vertical: AppSpacing.md,
                  horizontal: AppSpacing.lg,
                ),
            onPressed:
                widget.enabled! ? widget.onTap as void Function()? : null,
            color: widget.color ?? AppColors.white,
            shape: widget.shapeBorder ??
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.xlg),
                ),
            elevation: widget.elevation ?? AppSpacing.xs,
            animationDuration: const Duration(milliseconds: 300),
            height: widget.height,
            disabledColor: widget.disabledColor ?? AppColors.gray,
            focusColor: widget.focusColor,
            hoverColor: widget.hoverColor,
            splashColor: widget.splashColor,
            child: widget.child ??
                Text(
                  widget.text ?? '',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: widget.textColor ?? Colors.black,
                      ),
                ),
          ),
        ),
      );
}
