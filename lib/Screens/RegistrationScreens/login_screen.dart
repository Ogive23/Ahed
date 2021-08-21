import 'package:ahed/ApiCallers/UserApiCaller.dart';
import 'package:ahed/Session/session_manager.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ahed/Custom Widgets/CustomButtonLoading.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static final TextEditingController emailController =
      new TextEditingController();
  static final TextEditingController passwordController =
      new TextEditingController();
  static late double w, h;
  static late AppTheme appTheme;
  String error = '';
  bool isLoading = false;
  String get email => emailController.text;
  String get password => passwordController.text;

  Future<dynamic> onSubmit(context) async {
    changeLoadingState();
    UserApiCaller userApiCaller = new UserApiCaller();
    Map<String, dynamic> status = await userApiCaller.login(email, password);
    changeLoadingState();
    if (status['Err_Flag']) {
      setState(() {
        this.error = status['Err_Desc'];
      });
      return;
    }
    SessionManager sessionManager = new SessionManager();
    print(status['Values']);
    //ToDo: Access Token Duration
    sessionManager.createSession(
        status['Values'], DateTime.now().add(Duration(days: 30)));
    print('thing ${sessionManager.sharedPreferences}');
    Navigator.popUntil(context, (route) => false);
    Navigator.pushNamed(context, 'MainScreen');
  }

  changeLoadingState() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    appTheme = new AppTheme(false, context);
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
                    'assets/images/2018_12_05_4268-Edit.jpg',
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3), BlendMode.darken),
                  alignment: Alignment.center),
            ),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: h / 10, bottom: h / 50),
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
                    fontSize: appTheme.mediumTextSize(context),
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2.0,
                  ),
                  duration: Duration(seconds: 1),
                  curve: ElasticInCurve(4),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: h / 15, right: w / 20, left: w / 20),
                  padding: EdgeInsets.only(top: h / 100, bottom: h / 100),
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
                        padding: EdgeInsets.only(left: w / 25),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Sign In to your account',
                              style: appTheme.nonStaticGetTextStyle(
                                  2.0,
                                  Colors.white,
                                  appTheme.mediumTextSize(context),
                                  FontWeight.w300,
                                  1.0,
                                  TextDecoration.none,
                                  'OpenSans'),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: w / 25, vertical: h / 200),
                          child: TextField(
                            controller: emailController,
                            textAlign: TextAlign.center,
                            style: appTheme.nonStaticGetTextStyle(
                                1.0,
                                Colors.white,
                                appTheme.mediumTextSize(context),
                                FontWeight.normal,
                                1.0,
                                TextDecoration.none,
                                'OpenSans'),
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
                          padding: EdgeInsets.only(
                              top: h / 50, right: w / 25, left: w / 25),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.center,
                            style: appTheme.nonStaticGetTextStyle(
                                1.0,
                                Colors.white,
                                appTheme.mediumTextSize(context),
                                FontWeight.normal,
                                1.0,
                                TextDecoration.none,
                                'OpenSans'),
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
                        height: h / 50,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: w / 10),
                          child: Text(
                            error,
                            style: appTheme.nonStaticGetTextStyle(
                                1.0,
                                Colors.red,
                                appTheme.mediumTextSize(context),
                                FontWeight.bold,
                                1.0,
                                TextDecoration.none,
                                'OpenSans'),
                            textAlign: TextAlign.center,
                          )),
                      SizedBox(
                        height: h / 50,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isLoading
                                ? CustomButtonLoading()
                                : ElevatedButton(
                                    child: Text(
                                      'Login',
                                      style: appTheme.nonStaticGetTextStyle(
                                          1.0,
                                          Colors.white,
                                          appTheme
                                              .mediumTextSize(context),
                                          FontWeight.normal,
                                          1.0,
                                          TextDecoration.none,
                                          'OpenSans'),
                                      textAlign: TextAlign.center,
                                    ),
                                    style: ButtonStyle(
                                        minimumSize:
                                            MaterialStateProperty.all<Size>(
                                                Size(w / 4, h / 20)),
                                        backgroundColor: MaterialStateProperty.all<
                                                Color>(
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
                                style: appTheme.nonStaticGetTextStyle(
                                    1.0,
                                    Colors.red,
                                    appTheme.smallTextSize(context),
                                    FontWeight.normal,
                                    1.0,
                                    TextDecoration.underline,
                                    'OpenSans'),
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
                                style: appTheme.nonStaticGetTextStyle(
                                    1.0,
                                    Colors.white,
                                    appTheme.smallTextSize(context),
                                    FontWeight.normal,
                                    1.0,
                                    TextDecoration.none,
                                    'OpenSans'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, "SignUp");
                                },
                                child: Text(
                                  'Join Us Now!',
                                  style: appTheme.nonStaticGetTextStyle(
                                      1.0,
                                      Colors.green,
                                      appTheme.mediumTextSize(context),
                                      FontWeight.w600,
                                      1.0,
                                      TextDecoration.none,
                                      'OpenSans'),
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
