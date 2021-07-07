import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boletoModel.dart';
import 'package:payflow/shared/themes/appColors.dart';
import 'package:payflow/shared/themes/appTextStyles.dart';
import 'package:payflow/shared/widgets/boletoInfo/boletoInfoWidget.dart';
import 'package:payflow/shared/widgets/boletoList/boletoListController.dart';
import 'package:payflow/shared/widgets/boletoList/boletoListWidget.dart';

class ExtractPage extends StatefulWidget {
  final void Function({required BoletoModel boletoModel}) onTapBoletoTile;
  const ExtractPage({ Key? key, required this.onTapBoletoTile }) : super(key: key);

  @override
  ExtractPageState createState() => ExtractPageState();
}

class ExtractPageState extends State<ExtractPage> {

  final controller = BoletoListController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            child: Stack(
              children: [
                Container(
                  height: 44,
                  width: double.maxFinite,
                  color: AppColors.primary,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: ValueListenableBuilder<List<BoletoModel>>(
                    valueListenable: controller.boletosNotifier,
                    builder: (context, boletos, widget) =>
                      AnimatedCard(
                        direction: AnimatedCardDirection.top,
                        child: BoletoInfoWidget(boletoSize: boletos.length)
                      )
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 25, right: 25),
            child: Text(
              'Meus Extratos',
              style: AppTextStyles.titleBoldHeading,
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: Divider(
              thickness: 1,
              height: 1,
              color: AppColors.stroke
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: BoletoListWidget(controller: controller, onTapBoletoTile: widget.onTapBoletoTile),
          )
        ],
      ),
    );
  }
}
