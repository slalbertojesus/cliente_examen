import 'package:flutter/material.dart';
import 'package:merixo/main.dart';
import 'package:merixo/registro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/loginresponse.dart';
import 'package:flushbar/flushbar.dart';
import 'package:http/http.dart' as http;
import 'package:merixo/principal.dart';
import 'dart:convert';
import 'package:merixo/models/flush.dart';
import 'data/api.dart';

class InicioSesion extends StatefulWidget {
  @override
  _InicioSesionState createState() => new _InicioSesionState();
}

class _InicioSesionState extends State<InicioSesion> {
  var _jsonResponse;
  var _response;
  LoginResponse _responseLogin;
  Flush _notification;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.black,
        body: Wrap(runSpacing: 20, // to apply margin vertically
            children: <Widget>[
              headerSection(),
              textSection(),
              buttonSection(),
            ]));
  }

  void _showFlushbar(BuildContext context, Flush flusher) {
    Flushbar(
      title: flusher.title,
      flushbarPosition: FlushbarPosition.TOP,
      message: flusher.message,
      duration: Duration(seconds: flusher.duration),
    )..show(context);
  }

  signIn(String email, pass) async {
    Map loginCredentials = {'email': email, 'password': pass};
    _jsonResponse = await http.post("http://159.89.50.94:8000/login",
        body: loginCredentials);
        
    if (_jsonResponse.statusCode == 201) {
        print("Entro" + _jsonResponse.body);
      _response = json.decode(_jsonResponse.body);
      Map _jsonBody = json.decode(_jsonResponse.body);
      _responseLogin = LoginResponse.fromJson(_jsonBody);
      if (_response != null) {
        print("Entro" + _jsonResponse.body);
        await Merixo.shareUtils.set("token", _response['token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => Principal()),
            (Route<dynamic> route) => false);
      }
    }
    if (_jsonResponse.statusCode == 200) {

      print("Hubo un error" + _jsonResponse.body);
    } else {
      print("Hubo error en servidor" + _jsonResponse.body);
    }
  }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Container headerSection() {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Text('merixo',
          style: TextStyle(fontFamily: 'GalanoGrotesque', fontSize: 32)),
    );
  }

  

  Container textSection() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Column(children: <Widget>[
          TextField(
            controller: emailController,
            obscureText: false,
            decoration: new InputDecoration(
              labelText: "Email",
              hintStyle: TextStyle(fontSize: 20.0, color: Colors.redAccent),
              fillColor: Colors.black,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(),
              ),
            ),
            keyboardType: TextInputType.visiblePassword,
            style: TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: new InputDecoration(
              labelText: "Password",
              hintStyle: TextStyle(fontSize: 20.0, color: Colors.redAccent),
              fillColor: Colors.black,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(),
              ),
            ),
            keyboardType: TextInputType.visiblePassword,
            style: TextStyle(
              fontFamily: "Poppins",
            ),
          ),
        ]));
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: Wrap(
        runSpacing: 20,
        children: <Widget>[
          Center(
            child: Row(
              children: <Widget>[
                FlatButton(
                  child: Text("Ingresa"),
                  onPressed: () async {
                    setState(() {});
                    print("cosito");
                    signIn(emailController.text, passwordController.text);
                  },
                  color: Color.fromRGBO(253, 23, 23, 1),
                ),
                FlatButton(
                  child: Text("Registrar"),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Registro()),
                    );
                  },
                  color: Color.fromRGBO(253, 23, 23, 1),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
