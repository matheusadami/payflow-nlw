import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/appColors.dart';
import 'package:payflow/shared/themes/appImages.dart';
import 'package:payflow/shared/themes/appTextStyles.dart';

class BoletoInfoWidget extends StatelessWidget {
  final int boletoSize;
  const BoletoInfoWidget({ Key? key, required this.boletoSize }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              AppImages.logoMini,
              color: AppColors.background,
              width: 55,
              height: 35,
            ),
            Container(
              color: AppColors.background,
              width: 1,
              height: 32,
            ),
            Text.rich(
          TextSpan(
            text: 'Você tem ',
            style: AppTextStyles.captionBackground,
            children: [
              TextSpan(
                text: '$boletoSize boletos\n',
                style: AppTextStyles.captionBoldBackground
              ),
              TextSpan(
                text: 'cadastrados para pagar',
                style: AppTextStyles.captionBackground
              ),
            ]
          )
        ),
          ],
        ),
      ),
    );
  }
}