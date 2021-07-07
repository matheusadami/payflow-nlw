import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';

import 'package:payflow/shared/models/boletoModel.dart';
import 'package:payflow/shared/themes/appColors.dart';
import 'package:payflow/shared/themes/appTextStyles.dart';
import 'package:payflow/shared/widgets/boletoInfo/boletoInfoWidget.dart';
import 'package:payflow/shared/widgets/boletoList/boletoListController.dart';
import 'package:payflow/shared/widgets/boletoList/boletoListWidget.dart';

class MyBoletosPage extends StatefulWidget {
  final void Function({required BoletoModel boletoModel}) onTapBoletoTile;
  const MyBoletosPage({ Key? key, required this.onTapBoletoTile }) : super(key: key);

  @override
  MyBoletosPageState createState() => MyBoletosPageState();
}

class MyBoletosPageState extends State<MyBoletosPage> {

  BoletoListController controller = BoletoListController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              child: Stack(
                children: [
                  Container(
                    height: 50,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Meus Boletos',
                    style: AppTextStyles.titleBoldHeading,
                    textAlign: TextAlign.start,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/createBoleto');
                          },
                          child: Icon(
                            Icons.add_box_outlined,
                            color: AppColors.body
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                AlertDialog(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Ajuda',
                                        style: AppTextStyles.titleBoldHeading
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.close)
                                      )
                                    ],
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 5),
                                            child: Container(
                                              width: 10,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.circular(2.5)
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 5),
                                            child: Text(
                                              'Documento Pago',
                                              style: AppTextStyles.captionBoldBody,
                                            )
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 5),
                                            child: Container(
                                              width: 10,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                color: AppColors.stroke,
                                                borderRadius: BorderRadius.circular(2.5)
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 5),
                                            child: Text(
                                              'Pagamento Pendente',
                                              style: AppTextStyles.captionBoldBody,
                                            )
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                            );
                          },
                          child: Icon(
                            Icons.help,
                            color: AppColors.body
                          ),
                        ),
                      )
                    ],
                  )
                ],
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
              child: BoletoListWidget(
                controller: controller,
                onTapBoletoTile: widget.onTapBoletoTile
              ),
            )
          ],
        ),
      ),
    );
  }
}
