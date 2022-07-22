import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat_3/models/user_model.dart';
import 'package:flash_chat_3/screens/chat_screen.dart';
import 'package:flash_chat_3/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../widgets/Material_button_widget.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email = '';
  String password = '';
  bool showSpinner = false;
  final auth = FirebaseAuth.instance;
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
                  setState(() {});
                  email = value;
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              textfield_widget(
                hintText: 'Введите пароль',
                onChanged: (value) {
                  setState(() {});
                  password = value;
                },
                obscureText: true,
              ),
              const SizedBox(
                height: 24.0,
              ),
              Material_button_widget(
                  title: 'Регистрация',
                  color: Colors.blueAccent,
                  onPressed: () async {
                    //   if (email.isNotEmpty && password.isNotEmpty) {
                    //     try {
                    //       final credential = await FirebaseAuth.instance
                    //           .createUserWithEmailAndPassword(
                    //         email: email,
                    //         password: password,
                    //       );
                    //     } on FirebaseAuthException catch (e) {
                    //       if (e.code == 'weak-password') {
                    //         log('The password provided is too weak.');
                    //       } else if (e.code == 'email-already-in-use') {
                    //         log('The account already exists for that email.');
                    //       }
                    //     } catch (e) {
                    //       log(e);
                    //     }
                    //     ;
                    //     log(email);
                    //   }
                    // },
                    setState(() {
                      showSpinner = true;
                    });
                    await registration(email, password);
                    setState(() {
                      showSpinner = false;
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registration(String emailAdress, String passwordtext) async {
    try {
      final UserCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAdress,
        password: passwordtext,
      );
      log('$UserCredential');
      await addUserToServer(UserCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e);
    }
  }

  Future<void> addUserToServer(User user) async {
    final userModel =
        UserModel(id: user.uid, email: user.email, password: password);
    final userData = await FirebaseFirestore.instance
        .collection('user')
        .doc(user.uid)
        .set(userModel.toJson())
        .then((_) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => ChatScreen(
                    userModel: userModel,
                  ))));
    });
  }
}
