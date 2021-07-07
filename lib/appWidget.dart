import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payflow/modules/barcodeScanner/barcodeScannerPage.dart';
import 'package:payflow/modules/createBoleto/createBoletoPage.dart';
import 'package:payflow/modules/home/homePage.dart';
import 'package:payflow/modules/login/loginPage.dart';
import 'package:payflow/modules/splash/splashPage.dart';
import 'package:payflow/shared/models/userModel.dart';
import 'package:payflow/shared/themes/appColors.dart';

class AppWidget extends StatelessWidget {
  AppWidget() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pay Flow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: Colors.white
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/home': (context) => HomePage(user: ModalRoute.of(context)!.settings.arguments as UserModel),
        '/login': (context) => LoginPage(),
        '/createBoleto': (context) => CreateBoletoPage(barcode: ModalRoute.of(context)!.settings.arguments as String?),
        '/barcodeScanner': (context) => BarcodeScannerPage()
      },
    );
  }
}
