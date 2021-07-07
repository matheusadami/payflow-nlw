import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/appColors.dart';
import 'package:payflow/shared/themes/appTextStyles.dart';
import 'package:payflow/shared/widgets/labelButton/labelButtonWidget.dart';
import 'package:payflow/shared/widgets/verticalDivider/verticalDividerWidget.dart';

class SetLabelButtonsWidget extends StatelessWidget {
  final bool isPrimaryColorFirstLabelButton;
  final bool isPrimaryColorSecondaryLabelButton;

  final String firstLabelButton;
  final String secondaryLabelButton;

  final VoidCallback onTapFirstLabelButton;
  final VoidCallback onTapSecondaryLabelButton;

  const SetLabelButtonsWidget(
      {Key? key,
      required this.firstLabelButton,
      required this.secondaryLabelButton,
      required this.onTapFirstLabelButton,
      required this.onTapSecondaryLabelButton,
      this.isPrimaryColorFirstLabelButton = false,
      this.isPrimaryColorSecondaryLabelButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      height: 60,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            thickness: 1,
            height: 1,
            color: AppColors.stroke,
          ),
          Container(
            height: 55,
            child: Row(
              children: [
                Expanded(
                  child: LabelButtonWidget(
                      style: isPrimaryColorFirstLabelButton
                          ? AppTextStyles.buttonPrimary
                          : null,
                      label: firstLabelButton,
                      onTap: onTapFirstLabelButton),
                ),
                VerticalDividerWidget(),
                Expanded(
                  child: LabelButtonWidget(
                      style: isPrimaryColorSecondaryLabelButton
                          ? AppTextStyles.buttonPrimary
                          : null,
                      label: secondaryLabelButton,
                      onTap: onTapSecondaryLabelButton),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
