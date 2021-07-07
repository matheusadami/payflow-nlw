import 'package:flutter/material.dart';
import 'package:payflow/modules/barcodeScanner/barcodeScannerController.dart';
import 'package:payflow/modules/barcodeScanner/barcodeScannerStatus.dart';
import 'package:payflow/shared/themes/appColors.dart';
import 'package:payflow/shared/themes/appTextStyles.dart';
import 'package:payflow/shared/widgets/bottomSheet/bottomSheetWidget.dart';
import 'package:payflow/shared/widgets/setLabelButtons/setLabelButtonsWidget.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({ Key? key }) : super(key: key);

  @override
  BarcodeScannerPageState createState() => BarcodeScannerPageState();
}

class BarcodeScannerPageState extends State<BarcodeScannerPage> {

  final BarcodeScannerController controller = BarcodeScannerController();

  @override
  void initState() {
    controller.getAvailableBackCamera();

    controller.statusNotifier.addListener(() {
      if (controller.status.hasBarcode) {
        Navigator.pushReplacementNamed(context, '/createBoleto', arguments: controller.status.barcode);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: controller.statusNotifier,
            builder: (context, status, widget) =>
              status.showCamera
              ? Container(
                child: controller.cameraController!.buildPreview(),
              )
              : Container()
          ),

          RotatedBox(
            quarterTurns: 1,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                
                leading: BackButton(color: AppColors.background),
                backgroundColor: Colors.black,
                title: Text('Escaneie o código de barras do boleto', style: AppTextStyles.buttonBackground),
                centerTitle: true,
              ),

              body: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(color: Colors.black.withOpacity(0.5))
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(color: Colors.transparent)
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(color: Colors.black.withOpacity(0.5))
                  ),
                ],
              ),
          
              bottomNavigationBar: SetLabelButtonsWidget(
                firstLabelButton: 'Inserir código do boleto',
                onTapFirstLabelButton: () {
                  Navigator.pushReplacementNamed(context, '/createBoleto', arguments: '');
                },
                secondaryLabelButton: 'Adicionar da galeria',
                onTapSecondaryLabelButton: () {},
              ),
            ),
          ),

          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: controller.statusNotifier,
            builder: (context, status, widget) =>
              status.hasError
              ? BottomSheetWidget(
                  title: 'Não foi possível identificar um código de barras',
                  subtitle: 'Tente escanear novamente ou digite o código do seu boleto',
                  firstLabelButton: 'Escanear novamente',
                  secondaryLabelButton: 'Digitar código',
                  onTapFirstLabelButton: controller.scanWithCamera,
                  onTapSecondaryLabelButton: () {
                    Navigator.pushReplacementNamed(context, '/createBoleto', arguments: '');
                  },
                )
              : Container()
          ),
        ],
      ),
    );
  }
}
