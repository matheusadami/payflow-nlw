import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/appColors.dart';
import 'package:payflow/shared/themes/appTextStyles.dart';

class LabelButtonWidget extends StatelessWidget {

  final IconData? icon;
  final Color? iconColor;
  final TextStyle? style;
  final VoidCallback onTap;
  final String label;

  const LabelButtonWidget({
    Key? key,
    this.icon,
    this.iconColor,
    this.style,
    required this.onTap,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: TextButton(
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor),
            Text(
              label,
              style: style ?? AppTextStyles.buttonHeading
            ),
          ],
        )
      ),
    );
  }
}
