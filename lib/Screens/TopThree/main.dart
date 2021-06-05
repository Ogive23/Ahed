import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Session/session_manager.dart';
import '../../Shared Data/app_language.dart';
import '../../Shared Data/app_theme.dart';
import '../../Shared Data/common_data.dart';
import '../../Shared Data/NeedyData.dart';
import '../drawer_screen.dart';
import 'BackgroundScreen.dart';
import 'first_time_screens.dart';
import '../RegistrationScreens/login_screen.dart';
import '../RegistrationScreens/sign_up_screen.dart';
import 'splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ahed',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        "SplashScreen": (BuildContext context) => SplashScreen(),
        "MainScreen": (BuildContext context) => MainScreen(),
        "WelcomeScreen": (BuildContext context) => WelcomeScreen(),
        "LoginScreen": (BuildContext context) => LoginScreen(),
        "SignUp": (BuildContext context) => SignUpScreen(),
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  final SessionManager sessionManager = new SessionManager();
  static AppTheme appTheme;
  static AppLanguage appLanguage;
  final NeedyData needyData = new NeedyData();
  final CommonData commonData = new CommonData();
  @override
  Widget build(BuildContext context) {
    appTheme = new AppTheme(sessionManager.loadPreferredTheme());
    appLanguage = new AppLanguage(sessionManager.loadPreferredLanguage());
    return MultiProvider(providers: [
      ChangeNotifierProvider<AppTheme>(
        create: (context) => appTheme,
      ),
      ChangeNotifierProvider<AppLanguage>(
        create: (context) => appLanguage,
      ),
      ChangeNotifierProvider<CommonData>(
        create: (context) => commonData,
      ),
      ChangeNotifierProvider<NeedyData>(
        create: (context) => needyData,
      )
    ], child: BackgroundScreen());
  }
}
