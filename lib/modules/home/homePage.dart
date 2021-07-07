import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:payflow/shared/models/userModel.dart';
import 'package:payflow/shared/themes/appColors.dart';
import 'package:payflow/shared/models/boletoModel.dart';
import 'package:payflow/shared/auth/authController.dart';
import 'package:payflow/shared/themes/appTextStyles.dart';
import 'package:payflow/shared/widgets/boletoSheet/boletoSheetWidget.dart';

import 'package:payflow/modules/extract/extractPage.dart';
import 'package:payflow/modules/home/homeController.dart';
import 'package:payflow/modules/myBoletos/myBoletosPage.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  AuthController authController = AuthController();
  HomeController homeController = HomeController();

  void onTapBoletoTite({required BuildContext context, required BoletoModel boletoModel}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BoletoSheetWidget(boletoModel: boletoModel);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(185),
        child: Container(
          height: 185,
          color: AppColors.primary,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.user.photoURL!,
                      width: 50,
                      height: 50
                    )
                  ),
                  trailing: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: IconButton(
                          icon: Icon(Icons.logout, color: AppColors.background),
                          onPressed: () async {
                            bool isRemoved = await authController.removeUser();
                            if (isRemoved) {
                              Navigator.popAndPushNamed(context, '/login');
                            }
                          }
                        )
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text.rich(
                    TextSpan(
                      text: 'Olá, ',
                      style: AppTextStyles.titleRegular,
                      children: [
                        TextSpan(
                          text: widget.user.name,
                          style: AppTextStyles.titleBoldBackground
                        )
                      ]
                    )
                  ),
                  subtitle: Text(
                    'Mantenha suas contas em dia',
                    style: AppTextStyles.captionShape
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: Stack(
        children: [
          {
            Screens.home: Container(
              child: MyBoletosPage(
                key: UniqueKey(),
                onTapBoletoTile: ({required BoletoModel boletoModel}) {
                  onTapBoletoTite(boletoModel: boletoModel, context: context);
                }
              ),
            ),
            Screens.createBoleto: Container(
              child: ExtractPage(
                key: UniqueKey(),
                onTapBoletoTile: ({required BoletoModel boletoModel}) {
                  onTapBoletoTite(boletoModel: boletoModel, context: context);
                }
              )
            )
          }[homeController.currentPage] as Widget,
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 20,
              decoration: BoxDecoration(
                color: AppColors.background,
                gradient: LinearGradient(
                  end: Alignment.bottomCenter,
                  begin: Alignment.topCenter,
                  colors: [Colors.white.withOpacity(0.0), AppColors.background],
                  stops: [0.00, 1.50],
                )
              ),
            ),
          ),
        ],
      ),
      
      bottomNavigationBar: Container(
        color: AppColors.background,
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                homeController.setPage(Screens.home);
                setState(() {});
              },
              icon: Icon(Icons.home,
                color: homeController.currentPage == Screens.home
                    ? AppColors.primary
                    : AppColors.body
              )
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/barcodeScanner');
              },
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5)),
                child: Icon(
                  FontAwesomeIcons.cameraRetro,
                  color: AppColors.background
                )
              ),
            ),
            IconButton(
              onPressed: () {
                homeController.setPage(Screens.createBoleto);
                setState(() {});
              },
              icon: Icon(Icons.description_outlined,
                color: homeController.currentPage == Screens.createBoleto
                    ? AppColors.primary
                    : AppColors.body
              )
            )
          ],
        ),
      ),
    );
  }
}
