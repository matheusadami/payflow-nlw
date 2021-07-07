import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';

import 'package:payflow/shared/themes/appColors.dart';
import 'package:payflow/shared/themes/appImages.dart';
import 'package:payflow/shared/themes/appTextStyles.dart';
import 'package:payflow/shared/widgets/socialLogin/socialLoginButton.dart';
import 'package:payflow/modules/login/loginController.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final controller = LoginController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Container(
                height: size.height * 0.35,
                width: size.width,
                color: AppColors.primary),
            Positioned(
              top: size.height * 0.10,
              left: 0,
              right: 0,
              child: Image.asset(AppImages.person,
                width: 208,
                height: size.height * 0.4
              ),
            ),
            Positioned(
              top: size.height * 0.46,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white.withOpacity(0.0), Colors.white],
                    stops: [0.20, 0.50],
                  )
                )
              )
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).size.height * 0.08,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppImages.logoMini),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 70, right: 70),
                    child: Text(
                      'Organize seus boletos em um só lugar',
                      style: AppTextStyles.titleHome,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  AnimatedCard(
                    direction: AnimatedCardDirection.bottom,
                    duration: const Duration(seconds: 1),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 40, right: 40, top: 20),
                      child: SocialLoginButton(
                        onTap: () {
                          controller.googleSignIn(context);
                        },
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
