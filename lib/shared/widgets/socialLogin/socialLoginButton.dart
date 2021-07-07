import 'package:flutter/material.dart';

import 'package:payflow/shared/themes/appColors.dart';
import 'package:payflow/shared/themes/appImages.dart';
import 'package:payflow/shared/themes/appTextStyles.dart';

class SocialLoginButton extends StatelessWidget {
  final VoidCallback onTap;

  const SocialLoginButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            color: AppColors.shape,
            border: Border.fromBorderSide(BorderSide(color: AppColors.stroke)),
            borderRadius: BorderRadius.circular(5)),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Image.asset(AppImages.google),
                  ),
                  Container(
                    height: 60,
                    width: 1,
                    color: AppColors.stroke,
                  )
                ],
              )),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Entrar com Google',
                  style: AppTextStyles.buttonGray,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
