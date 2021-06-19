

import 'package:ahed/Screens/RegistrationScreens/login_screen.dart';

import 'Screens/NeediesScreens/NeediesScreen.dart';
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
  NeediesScreen,
  NeedyCreationScreen,
  OnlineTransactionCreationScreen,
  OfflineTransactionCreationScreen,
  ProfileScreen,
  StayInTouchScreen,
  LoginScreen
}
final pageTitles = [
  'عهد',
  'Settings',
  'Cases',
  'Create Case',
  'Donate',
  'Donate',
  'My Donations',
  'Profile',
  'Our Society',
  'Login'
];

final pageOptions = [
  MyDonationScreen(),
  HomeScreen(),
  SettingsScreen(),
  NeediesScreen(),
  NeedyCreationScreen(),
  OnlineTransactionCreationScreen(),
  OfflineTransactionCreationScreen(),
  ProfileScreen(),
  StayInTouchScreen(),
  LoginScreen()
];