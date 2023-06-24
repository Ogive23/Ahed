import 'package:ahed/Shared%20Data/TransactionData.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Session/session_manager.dart';
import 'Shared Data/app_language.dart';
import 'Shared Data/app_theme.dart';
import 'Shared Data/common_data.dart';
import 'Shared Data/NeedyData.dart';
import 'Screens/TopThree/BackgroundScreen.dart';
import 'first_time_screens.dart';
import 'Screens/RegistrationScreens/login_screen.dart';
import 'Screens/RegistrationScreens/sign_up_screen.dart';
import 'Screens/TopThree/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ErrorWidget.builder = (errorDetails) {
    return const Text('حدث خطأ ما');
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ahed',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: <String, WidgetBuilder>{
        'SplashScreen': (BuildContext context) => const SplashScreen(),
        'MainScreen': (BuildContext context) => MainScreen(),
        'WelcomeScreen': (BuildContext context) => const WelcomeScreen(),
        'LoginScreen': (BuildContext context) => LoginScreen(),
        'SignUp': (BuildContext context) => SignUpScreen(),
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  final SessionManager sessionManager = SessionManager();
  static late AppTheme appTheme;
  static late AppLanguage appLanguage;
  final NeedyData needyData = NeedyData();
  final CommonData commonData = CommonData();
  final TransactionData transactionData = TransactionData();

  MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    appTheme = AppTheme(sessionManager.loadPreferredTheme(),context);
    appLanguage = AppLanguage(sessionManager.loadPreferredLanguage());
    return MultiProvider(
        providers: [
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
          ),
          ChangeNotifierProvider<TransactionData>(
            create: (context) => transactionData,
          ),
        ],
        child: Directionality(
            textDirection: TextDirection.rtl, child: BackgroundScreen()));
  }
}
