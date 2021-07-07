import 'package:payflow/shared/models/boletoModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoletoSheetController {

  List<BoletoModel> boletos = <BoletoModel>[];

  Future<void> getBoletos() async {
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      final response = shared.getStringList('boletos') ?? <String>[];
      boletos = response.map((e) => BoletoModel.fromJson(e)).toList();
    } catch (e) {
      boletos = <BoletoModel>[];
    }
  }
  
  Future<bool> deleteBoleto(BoletoModel boletoModel) async {
    await getBoletos();
    SharedPreferences shared = await SharedPreferences.getInstance();
    boletos.removeWhere((el) => boletoModel == el);
    return await shared.setStringList('boletos', boletos.map((e) => e.toJson()).toList());
  }

  Future<bool> payBoleto(BoletoModel boletoModel) async {
    await getBoletos();
    SharedPreferences shared = await SharedPreferences.getInstance();
    var index = boletos.indexWhere((el) => boletoModel == el);
    if (index >= 0) {
      boletos[index] = boletoModel.copyWith(isPay: true);
      return await shared.setStringList('boletos', boletos.map((e) => e.toJson()).toList());
    }

    return Future<bool>.value(true);
  }

  Future<bool> receiveBoleto(BoletoModel boletoModel) async {
    await getBoletos();
    SharedPreferences shared = await SharedPreferences.getInstance();
    var index = boletos.indexWhere((el) => boletoModel == el);
    if (index >= 0) {
      boletos[index] = boletoModel.copyWith(isPay: false);
      return await shared.setStringList('boletos', boletos.map((e) => e.toJson()).toList());
    }

    return Future<bool>.value(true);
  }
}
