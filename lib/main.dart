import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:payflow/appWidget.dart';

void main() {
  runApp(AppFirebase());
}

class AppFirebase extends StatefulWidget {
  const AppFirebase({Key? key}) : super(key: key);

  @override
  AppFirebaseState createState() => AppFirebaseState();
}

class AppFirebaseState extends State<AppFirebase> {
  final Future<FirebaseApp> initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Material(
            child: Center(
              child: Text('Não foi possível carregar o firebase',
                  textDirection: TextDirection.ltr),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return AppWidget();
        }

        return Material(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
