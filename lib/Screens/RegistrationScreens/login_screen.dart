import 'package:ahed/Session/session_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static final TextEditingController emailController =
      new TextEditingController();
  static final TextEditingController passwordController =
      new TextEditingController();
  double w,h;

  String get email => emailController.text;
  String get password => passwordController.text;

  Future<dynamic> onSubmit(context) async {
    // Map<String, dynamic> map =
    // await apiCaller.get(userData: {'email': email, 'password': password});
    // if (map == null) {
    // Toast.show('Email Or Password are inCorrect!', context);
    // } else {
    SessionManager sessionManager = new SessionManager();
    print('thing ${sessionManager.sharedPreferences}');
    // sessionManager.createSession(
    //     map.values.toList().elementAt(1), map.values.toList().elementAt(0));
    Navigator.popAndPushNamed(context, 'MainScreen');
    // }
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Material(
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(39, 49, 56, 1.0),
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/nonprofit.png',
                  ),

                  alignment: Alignment.center),
            ),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                        top: h / 10,
                        bottom: h / 50),
                    child: Container(
                      height: h / 6,
                      width: h / 6,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage('assets/images/ogive_version_2.png'),
                        ),
                      ),
                    )),
                AnimatedDefaultTextStyle(
                  child: Text(
                    'Ascend By Giving',
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2.0,
                  ),
                  duration: Duration(seconds: 1),
                  curve: ElasticInCurve(4),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: h / 15,
                      right: 10,
                      left: 10),
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            offset: Offset(0, 2),
                            spreadRadius: 5,
                            blurRadius: 10)
                      ]),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Sign In to your account',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            )),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: TextField(
                            controller: emailController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.white)),
                          )),
                      Padding(
                          padding:
                              EdgeInsets.only(top: 20, right: 20, left: 20),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                                icon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                labelText: 'Password',
                                labelStyle: TextStyle(color: Colors.white)),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                child: Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(Size(w/4, h/20)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromRGBO(53, 67, 77, 1.0)),
                                    shape: MaterialStateProperty.all<
                                            OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)))),
                                onPressed: () {
                                  onSubmit(context);
                                },
                              ),
                            Padding(
                              padding: EdgeInsets.only(left: 25),
                              child: Text(
                                'Forgot password?',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  color: Colors.red[800],
                                  shadows: [
                                    // Shadow(
                                    //     color: Colors.black,
                                    //     offset: Offset(0, 1))
                                  ],
                                ),
                              ),
                            )
                          ]),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Don\'t have Account? ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, "SignUp");
                                },
                                child: Text(
                                  'Join Us Now!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[300],
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
