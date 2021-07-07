import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/appColors.dart';

class VerticalDividerWidget extends StatelessWidget {
  const VerticalDividerWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.stroke,
      width: 1,
      height: double.maxFinite,
    );
  }
}
