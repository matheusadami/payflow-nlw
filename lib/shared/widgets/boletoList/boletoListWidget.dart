import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boletoModel.dart';
import 'package:payflow/shared/widgets/boletoList/boletoListController.dart';
import 'package:payflow/shared/widgets/boletoTile/boletoTileWidget.dart';

class BoletoListWidget extends StatefulWidget {
  final void Function({required BoletoModel boletoModel}) onTapBoletoTile;
  final BoletoListController controller;

  const BoletoListWidget({ Key? key, required this.controller, required this.onTapBoletoTile }) : super(key: key);

  @override
  BoletoListWidgetState createState() => BoletoListWidgetState();
}

class BoletoListWidgetState extends State<BoletoListWidget> {

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<BoletoModel>>(
      valueListenable: widget.controller.boletosNotifier,
      builder: (context, boletos, _) => Column(
        children: boletos.map((e) =>
          InkWell(
            onTap: () {
              widget.onTapBoletoTile(boletoModel: e);
            },
            child: BoletoTileWidget(boletoModel: e)
          )
        ).toList(),
      )
    );
  }
}
