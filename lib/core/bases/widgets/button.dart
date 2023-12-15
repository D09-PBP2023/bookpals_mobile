import '../enum/button_type.dart';
import '../../theme/color_theme.dart';
import 'package:flutter/material.dart';

class BpButton extends StatelessWidget {
  final String text;
  final Function? onTap;
  final bool isLoading;
  final bool isDisabled;
  final BpButtonType buttonType;
  final double innerHorizontalPadding;
  final double innerVerticalPadding;
  const BpButton(
      {required this.text,
      this.onTap,
      this.buttonType = BpButtonType.primary,
      this.isLoading = false,
      this.isDisabled = false,
      this.innerHorizontalPadding = 20,
      this.innerVerticalPadding = 18,
      super.key});

  @override
  Widget build(BuildContext context) {
    Color textColor;
    Color buttonColor;

    switch (buttonType) {
      case BpButtonType.primary:
        textColor = ColorTheme.white;
        buttonColor = ColorTheme.primarySwatch;
        break;
      case BpButtonType.secondary:
        textColor = ColorTheme.white;
        buttonColor = ColorTheme.grey;
      case BpButtonType.tertiary:
        textColor = ColorTheme.white;
        buttonColor = Colors.transparent;
    }

    return InkWell(
      onTap: () {
        if (!isLoading & !isDisabled && onTap != null) {
          onTap!();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: innerVerticalPadding,
          horizontal: innerHorizontalPadding,
        ),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
        width: double.infinity,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
