import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat_3/screens/chat_screen.dart';
import 'package:flash_chat_3/screens/login_screen.dart';
import 'package:flash_chat_3/screens/registration_screen.dart';
import 'package:flash_chat_3/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: 'WelcomeScreen',
      routes: {
        'WelcomeScreen': (context) => WelcomeScreen(),
        'LoginScreen': (context) => LoginScreen(),
        'RegistrationScreen': (context) => RegistrationScreen(),
        'ChatScreen': (context) => ChatScreen(),
      },
    );
  }
}
