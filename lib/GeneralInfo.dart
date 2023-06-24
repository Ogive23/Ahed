

import 'package:ahed/Screens/RegistrationScreens/login_screen.dart';
import 'package:ahed/Screens/TransactionsScreens/OfflineTransactionUpdateScreen.dart';

import 'Screens/NeediesScreens/NeedyCreationScreen.dart';
import 'Screens/SideScreens/profile_screen.dart';
import 'Screens/SideScreens/settings_screen.dart';
import 'Screens/SideScreens/stay_in_touch_screen.dart';
import 'Screens/TopThree/HomeScreen.dart';
import 'Screens/TopThree/MyDonationScreen.dart';
import 'Screens/TransactionsScreens/OfflineTransactionCreationScreen.dart';
import 'Screens/TransactionsScreens/OnlineTransactionCreationScreen.dart';

enum Pages {
  MyDonationScreen,
  HomeScreen,
  SettingsScreen,
  NeedyCreationScreen,
  OnlineTransactionCreationScreen,
  OfflineTransactionCreationScreen,
  OfflineTransactionUpdateScreen,
  ProfileScreen,
  StayInTouchScreen,
  LoginScreen
}


final pageOptions = [
  MyDonationScreen(),
  HomeScreen(),
  SettingsScreen(),
  NeedyCreationScreen(),
  OnlineTransactionCreationScreen(),
  OfflineTransactionCreationScreen(),
  OfflineTransactionUpdateScreen(),
  ProfileScreen(),
  StayInTouchScreen(),
  LoginScreen()
];