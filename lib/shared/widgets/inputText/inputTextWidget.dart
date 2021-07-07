import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/appColors.dart';
import 'package:payflow/shared/themes/appTextStyles.dart';

class InputTextWidget extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final void Function(String value) onChanged;

  const InputTextWidget(
      {Key? key,
      this.validator,
      this.controller,
      required this.icon,
      required this.labelText,
      required this.onChanged,
      this.keyboardType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      direction: AnimatedCardDirection.left,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: Column(
          children: [
            TextFormField(
              keyboardType: keyboardType,
              controller: controller,
              validator: validator,
              onChanged: onChanged,
              style: AppTextStyles.input,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                labelText: labelText,
                labelStyle: AppTextStyles.input,
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Icon(
                        icon,
                        color: AppColors.primary,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 50,
                      color: AppColors.stroke,
                    )
                  ],
                ),
                border: InputBorder.none
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.stroke,
            )
          ],
        ),
      ),
    );
  }
}
