import 'dart:async';
import 'package:ahed/Session/MixPanelManager.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../../Session/session_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late SessionManager sessionManager;
  late MixPanelManager mixPanelManager;
  late AnimationController _animationController;
  late Animation<Color> _colorAnimation;
  double value = 0.0;
  double opacity = 0;
  String quote = '';
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _colorAnimation = Tween<Color>(begin: Colors.green, end: Colors.blue)
        .animate(_animationController);
    quote = [
      '“The purpose of life is not to be happy. It is to be useful,'
          ' to be honorable, to be compassionate,'
          ' to have it make some difference that you have lived and lived well.” \n ― Ralph Waldo Emerson',
      '“No one has ever become poor by giving.” \n'
          '― Anne Frank, diary of Anne Frank: the play',
      '“No one is useless in this world who lightens the burdens of another.”\n'
          '― Charles Dickens',
      '“There is no exercise better for the heart than reaching down and lifting people up.” \n'
          '― John Holmes',
      '“You have not lived today until you have done something for someone who can never repay you.”\n'
          '― John Bunyan'
    ].elementAt(Random().nextInt(5));
    sessionManager = SessionManager();
    mixPanelManager = new MixPanelManager();
    getSession();
    changeOpacity();
  }

  getSession() async {
    await sessionManager.getSessionManager();
    await mixPanelManager.initMixpanel();
    setState(() {});
  }

  getHomePage() {
    if (!sessionManager.notFirstTime()) return 'WelcomeScreen';
    if (sessionManager.isLoggedIn()) {
      sessionManager.loadSession();
    }
    return 'MainScreen';
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  changeOpacity() {
    if (value < 1.0) {
      Timer.periodic(
          const Duration(seconds: 1),
          (timer) => {
                if (mounted)
                  {
                    setState(() {
                      // value += 0.02;
                      value += 0.2;
                    })
                  }
              });
      Timer.periodic(
          const Duration(seconds: 3),
          (timer) => {
                if (mounted)
                  {
                    setState(() {
                      opacity = 1 - opacity;
                      changeOpacity();
                    })
                  }
              });
    } else {
      opacity = 1.0;
      navigate();
    }
  }

  navigate() {
    sessionManager.sharedPreferences == null
        ? Future.delayed(const Duration(seconds: 5), navigate())
        : Navigator.popAndPushNamed(context, getHomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AnimatedContainer(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(right: 40, left: 40),
          duration: const Duration(seconds: 3),
          decoration: const BoxDecoration(color: Colors.black),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: AnimatedOpacity(
                    opacity: opacity,
                    duration: const Duration(seconds: 2),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 3,
                      child: Image.asset('assets/images/Ahed.png'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    quote,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                            value < 1.0
                                ? '${(value * 100).toStringAsPrecision(3)}%'
                                : 'Welcome',
                            style: const TextStyle(color: Colors.white)),
                        LinearProgressIndicator(
                          value: value,
                          valueColor: _colorAnimation,
                          backgroundColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
