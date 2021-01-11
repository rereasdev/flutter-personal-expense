import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:personal_expenses/widgets/home_page.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedSplashScreen(
            customTween: DecorationTween(
              begin: BoxDecoration(color: Colors.white),
              end: BoxDecoration(color: Colors.white),
            ),
            splashTransition: SplashTransition.decoratedBoxTransition,
            splashIconSize: MediaQuery.of(context).size.width * 0.5,
            backgroundColor: Colors.white,
            animationDuration: Duration(milliseconds: 2500),
            duration: 2500,
            splash: Lottie.asset(
              'assets/animations/splash-screen.json',
              repeat: true,
              reverse: false,
              animate: true,
            ),
            nextScreen: MyHomePage(),
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.06),
                  child: Text(
                    'rereasdev',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      color: Colors.deepPurple[700],
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                    ),
                  ),
                )
              ]),
        ],
      ),
    );
  }
}
