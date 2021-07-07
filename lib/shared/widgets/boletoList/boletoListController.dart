import 'package:flutter/cupertino.dart';
import 'package:payflow/shared/models/boletoModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoletoListController {
  final boletosNotifier = ValueNotifier<List<BoletoModel>>(<BoletoModel>[]);
  List<BoletoModel> get boletos => boletosNotifier.value;
  set boletos(List<BoletoModel> boletos) => boletosNotifier.value = boletos;

  BoletoListController() {
    getBoletos();
  }

  Future<void> getBoletos() async {
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      final response = shared.getStringList('boletos') ?? <String>[];
      boletos = response.map((e) => BoletoModel.fromJson(e)).toList();
    } catch (e) {
      boletos = <BoletoModel>[];
    }
  }
}
