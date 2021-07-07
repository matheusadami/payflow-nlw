import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/appColors.dart';

class SimpleButtonWidget extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color borderBackgroundColor;
  final TextStyle labelStyle;
  final VoidCallback onTap;

  const SimpleButtonWidget({
    Key? key,
    required this.label,
    required this.backgroundColor,
    required this.borderBackgroundColor,
    required this.labelStyle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 140,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderBackgroundColor,
            width: 1
          ),
          borderRadius: BorderRadius.circular(4)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              label,
              style: labelStyle,
            ),
          ),
        )
      ),
    );
  }
}
