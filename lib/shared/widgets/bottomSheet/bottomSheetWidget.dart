import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/appColors.dart';
import 'package:payflow/shared/themes/appTextStyles.dart';
import 'package:payflow/shared/widgets/setLabelButtons/setLabelButtonsWidget.dart';

class BottomSheetWidget extends StatelessWidget {

  final String title;
  final String subtitle;

  final String firstLabelButton;
  final String secondaryLabelButton;

  final VoidCallback onTapFirstLabelButton;
  final VoidCallback onTapSecondaryLabelButton;

  const BottomSheetWidget({
    Key? key, required this.firstLabelButton, required this.secondaryLabelButton,
    required this.onTapFirstLabelButton, required this.onTapSecondaryLabelButton,
    required this.title, required this.subtitle }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RotatedBox(
        quarterTurns: 1,
        child: Material(
          child: Container(
            color: AppColors.shape,
            child: Column(
              children: [
                Expanded(
                  child: Container(color: Colors.black.withOpacity(0.5))
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: Text.rich(
                        TextSpan(
                          style: AppTextStyles.buttonBoldHeading,
                          text: title,
                          children: [
                            TextSpan(
                              style: AppTextStyles.buttonHeading,
                              text: "\n$subtitle",
                            )
                          ]
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      height: 1,
                      color: AppColors.stroke,
                    ),
                    SetLabelButtonsWidget(
                      firstLabelButton: firstLabelButton,
                      secondaryLabelButton: secondaryLabelButton,
                      onTapFirstLabelButton: onTapFirstLabelButton,
                      onTapSecondaryLabelButton: onTapSecondaryLabelButton,
                      isPrimaryColorFirstLabelButton: true,
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
