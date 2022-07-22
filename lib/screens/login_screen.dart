import 'package:flash_chat_3/screens/chat_screen.dart';
import 'package:flash_chat_3/widgets/Material_button_widget.dart';
import 'package:flash_chat_3/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              textfield_widget(
                hintText: 'Введите email',
                onChanged: (value) {
                  value = email;
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              textfield_widget(
                hintText: 'Введите пароль',
                obscureText: true,
                onChanged: (value) {
                  value = password;
                },
              ),
              const SizedBox(
                height: 24.0,
              ),
              Material_button_widget(
                title: 'Войти',
                color: Colors.lightBlueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  await login(email, password);
                  setState(() {
                    showSpinner = false;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login(String emailAdress, String passwordtext) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAdress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
