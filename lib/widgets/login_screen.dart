import 'package:flutter/material.dart';
import 'package:gbridgeapp/models/login_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final login = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginModel>(builder: this.doBuild);
  }

  Widget doBuild(BuildContext context, LoginModel model, Widget child) {

    final emailField = TextField(
      obscureText: false,
      style: style,
      controller: login,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Api key", //"Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

//    final passwordField = TextField(
//      obscureText: true,
//      style: style,
//      decoration: InputDecoration(
//          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//          hintText: "Password",
//          border:
//              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
//    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () => model.login(login.value.text, "ignorePassword"),
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: model.loading ? CircularProgressIndicator() : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
//                SizedBox(
//                  height: 155.0,
//                  child: Image.asset(
//                    "assets/logo.png",
//                    fit: BoxFit.contain,
//                  ),
//                ),
                SizedBox(height: 45.0),
                emailField,
//                SizedBox(height: 25.0),
//                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginButton,
                SizedBox(
                  height: 15.0,
                ),
                Text(model.lastError ?? ""),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    login.dispose();
    super.dispose();
  }
}
