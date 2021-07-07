import 'package:flutter/material.dart';
import 'package:payflow/shared/auth/authController.dart';
import 'package:payflow/shared/models/boletoModel.dart';
import 'package:payflow/shared/themes/appColors.dart';
import 'package:payflow/shared/themes/appTextStyles.dart';
import 'package:payflow/shared/widgets/boletoSheet/boletoSheetController.dart';
import 'package:payflow/shared/widgets/labelButton/labelButtonWidget.dart';
import 'package:payflow/shared/widgets/simpleButton/simpleButtonWidget.dart';

class BoletoSheetWidget extends StatefulWidget {
  final BoletoModel boletoModel;
  const BoletoSheetWidget({ Key? key, required this.boletoModel }) : super(key: key);

  @override
  BoletoSheetWidgetState createState() => BoletoSheetWidgetState();
}

class BoletoSheetWidgetState extends State<BoletoSheetWidget> {
  final controller = BoletoSheetController();
  final authController = AuthController();

  void payBoleto(BuildContext context) async {
    var isPayed = await controller.payBoleto(widget.boletoModel);
    if (isPayed) {
      await authController.currentUser(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              'Boleto alterado com sucesso',
              style: AppTextStyles.buttonBoldBackground,
              textAlign: TextAlign.center,
            ),
          ),
          backgroundColor: Colors.green,
        )
      );

      Navigator.popAndPushNamed(context, '/home', arguments: authController.user);
    }
  }

  void receiveBoleto(BuildContext context) async {
    if (widget.boletoModel.isPay ?? false) {
      var isReceive = await controller.receiveBoleto(widget.boletoModel);
      if (isReceive) {
        await authController.currentUser(context);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                'Boleto alterado com sucesso',
                style: AppTextStyles.buttonBoldBackground,
                textAlign: TextAlign.center,
              ),
            ),
            backgroundColor: Colors.green,
          )
        );

        Navigator.popAndPushNamed(context, '/home', arguments: authController.user);
      }
    }
    else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Text.rich(
            TextSpan(
              text: 'O boleto ',
              style: AppTextStyles.titleRegularHeading,
              children: [
                TextSpan(
                  text: widget.boletoModel.name,
                  style: AppTextStyles.titleBoldHeading
                ),
                TextSpan(
                  text: ' no valor de ',
                  style: AppTextStyles.titleRegularHeading
                ),
                TextSpan(
                  text: 'R\$ ${widget.boletoModel.value}',
                  style: AppTextStyles.titleBoldHeading
                ),
                TextSpan(
                  text: '\n foi pago? ',
                  style: AppTextStyles.titleRegularHeading
                ),
              ]
            ),
            textAlign: TextAlign.center,
          )
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SimpleButtonWidget(
                label: 'Não',
                labelStyle: AppTextStyles.buttonHeading,
                backgroundColor: Colors.transparent,
                borderBackgroundColor: AppColors.stroke,
                onTap: () {
                  receiveBoleto(context);
                },
              ),
              SimpleButtonWidget(
                label: 'Sim',
                labelStyle: AppTextStyles.buttonBackground,
                backgroundColor: AppColors.primary,
                borderBackgroundColor: AppColors.primary,
                onTap: () {
                  payBoleto(context);
                }
              )
            ],
          ),
        ),
        Container(
          height: 1,
          color: AppColors.stroke,
        ),
        LabelButtonWidget(
          onTap: () async {
            bool isRemoved = await controller.deleteBoleto(widget.boletoModel);
            if (isRemoved) {
              await authController.currentUser(context);
              Navigator.popAndPushNamed(context, '/home', arguments: authController.user);
            }
          },
          label: 'Deletar Boleto',
          style: AppTextStyles.buttonDelete,
          icon: Icons.delete,
          iconColor: AppColors.delete,
        )
      ],
    );
  }
}
