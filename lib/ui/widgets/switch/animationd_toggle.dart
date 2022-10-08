import 'package:flutter/material.dart';
import '../../colors/app_colors.dart';
import '../../spacing/app_spacing.dart';

// ignore: must_be_immutable
class AnimatedToggle extends StatefulWidget {
  AnimatedToggle({
    required this.values,
    required this.onToggleCallback,
    super.key,
    this.backgroundColor = AppColors.whiteBackground,
    this.buttonColor = AppColors.white,
    this.textColor = AppColors.black,
    this.initialPosition = true,
  });
  final List<Widget> values;
  final ValueChanged onToggleCallback;
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;
  late bool initialPosition;
  @override
  AnimatedToggleState createState() => AnimatedToggleState();
}

class AnimatedToggleState extends State<AnimatedToggle> {
  @override
  Widget build(BuildContext context) => Container(
        width: 120,
        height: MediaQuery.of(context).size.width * 0.13,
        margin: const EdgeInsets.all(AppSpacing.md),
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                widget.initialPosition = !widget.initialPosition;
                var index = 0;
                if (!widget.initialPosition) {
                  index = 1;
                }
                widget.onToggleCallback(index);
                setState(() {});
              },
              child: Container(
                height: MediaQuery.of(context).size.width * 0.13,
                decoration: ShapeDecoration(
                  color: widget.backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    widget.values.length,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.03,
                      ),
                      child: widget.values[index],
                    ),
                  ),
                ),
              ),
            ),
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              curve: Curves.decelerate,
              alignment: widget.initialPosition
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Container(
                width: 65,
                decoration: ShapeDecoration(
                  color: widget.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.1,
                    ),
                  ),
                ),
                alignment: Alignment.center,
                child: widget.initialPosition
                    ? widget.values[0]
                    : widget.values[1],
              ),
            ),
          ],
        ),
      );
}
