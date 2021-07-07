import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boletoModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateBoletoController {
  final formKey = GlobalKey<FormState>();
  BoletoModel boletoModel = BoletoModel();

  String? nameValidator(String? value) =>
      value?.isEmpty ?? true ? 'Favor informar o nome do boleto' : null;

  String? dueDateValidator(String? value) =>
      value?.isEmpty ?? true ? 'Favor informar a data de vencimento' : null;

  String? moneyValidator(double value) =>
      value < 1 ? 'Favor informar o valor do boleto' : null;

  String? boletoCodeValidator(String? value) =>
      value?.isEmpty ?? true ? 'Favor informar o código do boleto' : null;

  void onChange({String? name, String? dueDate, double? value, String? barcode}) {
    boletoModel = boletoModel.copyWith(name: name, dueDate: dueDate, value: value, barcode: barcode);
  }

  Future<bool> recordBoleto() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    final boletos = shared.getStringList('boletos') ?? <String>[];
    boletos.add(boletoModel.toJson());
    await shared.setStringList('boletos', boletos);
    return true;
  }

  Future<bool> saveBoleto() async {
    var form = formKey.currentState;
    if (form!.validate()) {
      return recordBoleto();
    }
    return false;
  }
}
