import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boletoModel.dart';
import 'package:payflow/shared/themes/appColors.dart';
import 'package:payflow/shared/themes/appTextStyles.dart';

class BoletoTileWidget extends StatelessWidget {
  final BoletoModel boletoModel;
  final VoidCallback? onTap;
  const BoletoTileWidget({ Key? key, required this.boletoModel, this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      direction: AnimatedCardDirection.right,
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          contentPadding: const EdgeInsets.all(0),
          dense: true,
          title: Text(
            boletoModel.name!,
            style: AppTextStyles.titleListTile,
          ),
          subtitle: Text.rich(
            TextSpan(
              text: 'Vence em ',
              style: AppTextStyles.captionBody,
              children: [
                TextSpan(
                  text: boletoModel.dueDate!,
                  style: AppTextStyles.captionBoldBody
                )
              ]
            )
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text.rich(
                TextSpan(
                  text: 'R\$ ',
                  style: AppTextStyles.trailingRegular,
                  children: [
                    TextSpan(
                      text: boletoModel.value!.toStringAsFixed(2),
                      style: AppTextStyles.trailingBold
                    )
                  ]
                )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7),
                child: Container(
                  width: 10,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                    color: boletoModel.isPay ?? false ? Colors.green : AppColors.stroke,
                    borderRadius: BorderRadius.circular(2.5)
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
