import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:merixo/models/getresponse.dart';
import 'package:merixo/models/loginresponse.dart';
import 'package:merixo/share/shareutils.dart';
import 'package:merixo/data/api.dart';
import 'dart:convert';
import 'package:merixo/main.dart';
import 'package:intl/intl.dart';
import 'dart:ui';


class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => new _PrincipalState();
}

class _PrincipalState extends State<Principal> with SingleTickerProviderStateMixin {
  TabController controller;
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  LoginResponse usuario;
  GetResponse responseGet;

  _PrincipalState({this.usuario});
  var _jsonResponse;
  Map <String, String> headers= {};

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 3);
    this.getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    final String token = await Merixo.shareUtils.get("token");
    String auth = "Token " + token;
    headers = {'Authorization': auth};
    _jsonResponse = await http.get("http://159.89.50.94:8000/properties", headers: headers);
    if (_jsonResponse.statusCode == 200) {
      var now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd');
      String formatted = formatter.format(now);
      _showSnackBar(formatted);
      Map _jsonBody = json.decode(_jsonResponse.body); 
      this.responseGet = GetResponse.fromJson(_jsonBody);
    } else {
    } 
  }

   void _showSnackBar(String text) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
          title: new Text("Merixo"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  
                }),
          ],
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          bottom: new TabBar(controller: controller, tabs: <Tab>[
            new Tab(text: "Chat"),
            new Tab(text: "Feed"),
            new Tab(text: "Contactos"),
          ])),
      
    );
  }
}
