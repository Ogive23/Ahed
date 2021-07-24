import 'package:ahed/Custom%20Widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _fullName = new TextEditingController();
  TextEditingController _userName = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  static late String nameError;
  static late String userNameError;
  static late String emailError;
  static late String passswordError;
  bool agree = false;
  bool errorAgree = false;

  // ApiCaller apiCaller = new UserApi();
  @override
  void initState() {
    super.initState();
  }

  void _register() async {
    agree == false ? errorAgree = true : errorAgree = false;
    // if (agree == true) {
    //   Map<String, dynamic> map = await apiCaller.create(userData: {
    //     'fullName': _fullName.value.text,
    //     'userName': _userName.value.text,
    //     'email': _email.value.text,
    //     'password': _password.value.text
    //   });
    //   if (map.values.elementAt(0) == 'done') {
    //     Navigator.popAndPushNamed(context, "Login");
    //   } else if (map.values.elementAt(0) == 'undone') {
    //     nameError = map.values.elementAt(1).elementAt(0);
    //     userNameError = map.values.elementAt(1).elementAt(1);
    //     emailError = map.values.elementAt(1).elementAt(2);
    //     passswordError = map.values.elementAt(1).elementAt(3);
    //   }
    // }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Material(
          child: Container(
              decoration: BoxDecoration(
                  gradient: RadialGradient(radius: 1, colors: [
                    Color.fromRGBO(242, 95, 76, 0.5),
                    Color.fromRGBO(229, 49, 112, 0.5),
                    Color.fromRGBO(15, 14, 23, 1)
                  ])),
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 30, bottom: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/ogive_version_2.png',
                      alignment: Alignment.topCenter,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 7,
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // CustomTextField(
                    //     _fullName,
                    //     'Full name',
                    //     Icons.person,
                    //     Colors.green,
                    //     Colors.white,
                    //     false,
                    //     null,
                    //     'Enter your real name',
                    //     nameError),
                    // CustomTextField(
                    //     _userName,
                    //     'User name',
                    //     Icons.person,
                    //     Colors.pink,
                    //     Colors.white,
                    //     false,
                    //     null,
                    //     'Enter the name you want to appear',
                    //     userNameError), //must be unique
                    // CustomTextField(
                    //     _email,
                    //     'Email',
                    //     Icons.email,
                    //     Color.fromRGBO(255, 216, 3, 1),
                    //     Colors.white,
                    //     false,
                    //     null,
                    //     'Enter your email',
                    //     emailError), //must be unique
                    // CustomTextField(
                    //     _password,
                    //     'Password',
                    //     Icons.lock,
                    //     Color.fromRGBO(242, 95, 76, 1),
                    //     Colors.white,
                    //     true,
                    //     null,
                    //     'use powerful password',
                    //     passswordError), //good password
                    // CheckboxListTile(
                    //   value: agree,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       agree = value;
                    //     });
                    //   },
                    //   title: Text('I agree terms'),
                    //   controlAffinity: ListTileControlAffinity.leading,
                    //   subtitle: GestureDetector(
                    //     onTap: () {
                    //       //Todo: add terms to read
                    //     },
                    //     child: Text('Click here to see our terms'),
                    //   ),
                    //   secondary: Icon(Icons.book),
                    // ),
                    // Visibility(
                    //     child: Text('Why you don\'t wanna agree?',
                    //         style: TextStyle(color: Colors.red)),
                    //     visible: errorAgree),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // ElevatedButton(
                    //   style: ButtonStyle(
                    //     backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(255, 137, 6, 1))
                    //   ),
                    //   onPressed: _register,
                    //   child: Text('Signup'),
                    // )
                  ],
                ),
              )),
        ));
  }
}
