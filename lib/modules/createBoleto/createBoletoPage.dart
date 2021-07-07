import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/modules/createBoleto/createBoletoController.dart';
import 'package:payflow/shared/auth/authController.dart';
import 'package:payflow/shared/themes/appColors.dart';
import 'package:payflow/shared/themes/appTextStyles.dart';
import 'package:payflow/shared/widgets/inputText/inputTextWidget.dart';
import 'package:payflow/shared/widgets/setLabelButtons/setLabelButtonsWidget.dart';

class CreateBoletoPage extends StatefulWidget {
  final String? barcode;
  const CreateBoletoPage({Key? key, this.barcode}) : super(key: key);

  @override
  CreateBoletoPageState createState() => CreateBoletoPageState();
}

class CreateBoletoPageState extends State<CreateBoletoPage> {
  final authController = AuthController();
  final controller = CreateBoletoController();

  final moneyInputTextController =
      MoneyMaskedTextController(leftSymbol: 'R\$', decimalSeparator: ',');
  final dueDateInputTextController = MaskedTextController(mask: '00/00/0000');
  final barcodeInputTextController = TextEditingController();

  @override
  void initState() {
    barcodeInputTextController.text = widget.barcode ?? '';
    super.initState();
  }

  void saveBoleto(BuildContext context) async {
    bool isSaved = await controller.saveBoleto();
    if (isSaved) {
      await authController.currentUser(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              'Boleto cadastrado com sucesso',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: BackButton(color: AppColors.input),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                child: Text(
                  'Preencha os dados do boleto',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.titleBoldHeading,
                ),
              ),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    InputTextWidget(
                      icon: Icons.description_outlined,
                      labelText: "Nome do boleto",
                      validator: controller.nameValidator,
                      onChanged: (String value) {
                        controller.onChange(name: value);
                      },
                    ),
                    InputTextWidget(
                      icon: FontAwesomeIcons.timesCircle,
                      labelText: "Data de vencimento",
                      controller: dueDateInputTextController,
                      validator: controller.dueDateValidator,
                      onChanged: (String value) {
                        controller.onChange(dueDate: value);
                      },
                      keyboardType: TextInputType.number,
                    ),
                    InputTextWidget(
                      icon: FontAwesomeIcons.wallet,
                      validator: (value) => controller.moneyValidator(
                          moneyInputTextController.numberValue),
                      labelText: "Valor",
                      controller: moneyInputTextController,
                      onChanged: (String value) {
                        controller.onChange(
                            value: moneyInputTextController.numberValue);
                      },
                      keyboardType: TextInputType.number,
                    ),
                    InputTextWidget(
                      icon: FontAwesomeIcons.barcode,
                      labelText: "Número do boleto",
                      validator: controller.boletoCodeValidator,
                      controller: barcodeInputTextController,
                      onChanged: (String value) {
                        controller.onChange(barcode: value);
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SetLabelButtonsWidget(
        firstLabelButton: "Cancelar",
        onTapFirstLabelButton: () {
          Navigator.pop(context);
        },
        secondaryLabelButton: "Cadastrar",
        onTapSecondaryLabelButton: () {
          saveBoleto(context);
        },
        isPrimaryColorSecondaryLabelButton: true,
      ),
    );
  }
}
