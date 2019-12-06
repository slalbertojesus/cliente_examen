import 'package:flutter/material.dart';
import 'package:merixo/inicio_sesion.dart';
import 'share/shareutils.dart';

void main() {
  runApp(Merixo());
}

class Merixo extends StatelessWidget {
 static ShareUtils shareUtils;
  @override
  Widget build(BuildContext context) {
    shareUtils = new ShareUtils();
    shareUtils.sharedPreferencesInstance();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Merixo",
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black, 
        cursorColor: Colors.red,
        accentColor: Colors.red,
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: new InicioSesion(),
    );
  }
}