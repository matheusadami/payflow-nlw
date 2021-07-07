import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow/shared/auth/authController.dart';
import 'package:payflow/shared/models/userModel.dart';

class LoginController {
  final authController = AuthController();

  Future<void> googleSignIn(BuildContext context) async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );

      GoogleSignInAccount? response = await googleSignIn.signIn();
      var user =
          UserModel(name: response!.displayName!, photoURL: response.photoUrl);
      await authController.saveUser(user);
      authController.redirectUser(context);
    } catch (error) {
      authController.setUser(null);
    }
  }
}
