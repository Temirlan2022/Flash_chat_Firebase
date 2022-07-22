import 'package:flash_chat_3/screens/login_screen.dart';
import 'package:flash_chat_3/screens/registration_screen.dart';
import 'package:flash_chat_3/widgets/Material_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    animation =
        ColorTween(begin: Color.fromARGB(255, 70, 68, 68), end: Colors.white)
            .animate(controller);
    //контроллер будет двигатся вперед
    controller.forward();
    //controller.reverse(from: 1.0); будет двигатся назад от 1 до 0
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                      child: Image.asset('assets/images/logo.png'),
                      height: 60.0),
                ),
                DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText('Flash Chat'),
                    ],
                    isRepeatingAnimation: true,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            Material_button_widget(
              title: 'Войти',
              color: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
            Material_button_widget(
              title: 'Регистрация',
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegistrationScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
