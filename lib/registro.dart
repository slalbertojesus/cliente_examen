import 'package:flutter/material.dart';
import 'package:merixo/models/user.dart';
import 'inicio_sesion.dart';
import 'package:http/http.dart' as http;
import 'package:flushbar/flushbar.dart';
import 'dart:convert';



class Registro extends StatefulWidget {
  Registro({Key key}) : super(key: key);

  @override
  _RegistroState createState() => new _RegistroState();
}

class _RegistroState extends State<Registro> {
  final TextEditingController userController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController passwordTwoController = new TextEditingController();

  Future<User> createPost({Map body}) async {
  return http.post("http://159.89.50.94:8000/create", body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    _showFlushbar(context);
    return User.fromJson(json.decode(response.body));
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: true,
      title: new Center(
              child: Text('merixo',
                  style:
                      TextStyle(fontFamily: 'GalanoGrotesque', fontSize: 32)),
            )

      ),
    
        body:  Center(
            child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(15.0),
                children: <Widget>[
          TextField(
            controller: userController,
            obscureText: false,
            decoration: new InputDecoration(
              labelText: "Usuario",
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
            controller: nameController,
            obscureText: false,
            decoration: new InputDecoration(
              labelText: "Nombre",
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
            controller: emailController,
            obscureText: false,
            decoration: new InputDecoration(
              labelText: "Correo",
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
            obscureText: false,
            decoration: new InputDecoration(
              labelText: "Contraseña",
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
            controller: passwordTwoController,
            obscureText: false,
            decoration: new InputDecoration(
              labelText: "Contraseña  ",
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
          Center(
            child: Column(
              children: <Widget>[
                FlatButton(
                  child: Text("Registrar"),
                  onPressed: () async {
                    User user = new User(
                        name: nameController.text, 
                        email: emailController.text,
                        username: userController.text,
                        password: passwordController.text,
                        passwordConfirm: passwordTwoController.text,
                        );
                    User usuario = await createPost(body: user.toMap());
                  },
                  color: Color.fromRGBO(253, 23, 23, 1),
                ),
              ],
            ),
          )
        ])));
  }

  void _showFlushbar(BuildContext context) {
    Flushbar(
      title: "Usuario registrado",
      flushbarPosition: FlushbarPosition.TOP,
      message: "Puedes iniciar sesión",
      duration: Duration(seconds: 10),
    )..show(context);
  }

}
