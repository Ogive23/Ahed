import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'Custom Widgets/text.dart';
import 'Session/session_manager.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(186, 224, 255, 1),
        body: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Lottie.asset(
                  'assets/animations/7520-welcome.json',
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 2,
                ),
                const SizedBox(height: 30),
                CustomText(
                  sentence: 'Welcome To Ahed App!',
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.height / 30,
                  letterSpacing: 1.0,
                  textFamily: 'Delius',
                ),
                const SizedBox(height: 10),
                CustomText(
                  sentence: 'We gonna help you to change \nTHE WORLD.',
                  color: Colors.blue,
                  fontSize: MediaQuery.of(context).size.height / 40,
                  letterSpacing: 1.5,
                  textFamily: 'Delius',
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)))),
                    ),
                    icon: const Icon(
                      Icons.fast_forward,
                      color: Colors.green,
                    ),
                    label: CustomText(
                      sentence: 'Continue',
                      color: Colors.green,
                      fontSize: MediaQuery.of(context).size.height / 40,
                      letterSpacing: 1.5,
                      textFamily: 'Delius',
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PreferredThemeTakingScreen()));
                    })
              ],
            ))));
  }
}

class PreferredThemeTakingScreen extends StatelessWidget {
  final SessionManager sessionManager = SessionManager();

  PreferredThemeTakingScreen({super.key});
  void finishedChoosing(context, bool theme) {
    sessionManager.createPreferredTheme(theme);
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PreferredLanguageTakingScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(186, 224, 255, 1),
        body: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CustomText(
                    sentence: 'Now Tell us which theme do you prefer?',
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height / 35,

                    letterSpacing: 1.5,

                    textFamily: 'Delius',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: CustomText(
                          sentence: 'White Theme',
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.height / 40,

                          letterSpacing: 1.5,

                          textFamily: 'Delius',
                        ),
                        onPressed: () {
                          finishedChoosing(context, false);
                        },
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                        ),
                        child: CustomText(
                          sentence: 'Black Theme',
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height / 40,

                          letterSpacing: 1.5,

                          textFamily: 'Delius',
                        ),
                        onPressed: () {
                          finishedChoosing(context, true);
                        },
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}

class PreferredLanguageTakingScreen extends StatelessWidget {
  final SessionManager sessionManager = SessionManager();

  PreferredLanguageTakingScreen({super.key});
  void finishedChoosing(context, String lang) {
    sessionManager.createPreferredLanguage(lang);
    sessionManager.changeStatus();
    Navigator.popAndPushNamed(context, 'MainScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(186, 224, 255, 1),
        body: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CustomText(
                    sentence:
                        'Now, Tell us which Language do you prefer?\n الآن، أخبرنا ما هي اللغة التي تفضلها؟',
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height / 35,

                    letterSpacing: 1.5,

                    textFamily: 'Delius',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: CustomText(
                          sentence: 'العربية',
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.height / 40,

                          letterSpacing: 1.5,

                          textFamily: 'Delius',
                        ),
                        onPressed: () {
                          finishedChoosing(context, 'Ar');
                        },
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                        ),
                        child: CustomText(
                          sentence: 'English',
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height / 40,

                          letterSpacing: 1.5,

                          textFamily: 'Delius',
                        ),
                        onPressed: () {
                          finishedChoosing(context, 'En');
                        },
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}
