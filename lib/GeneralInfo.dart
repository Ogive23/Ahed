

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
  HomeScreen,
  SettingsScreen,
  NeediesScreen,
  NeedyCreationScreen,
  OnlineTransactionCreationScreen,
  OfflineTransactionCreationScreen,
  MyDonationScreen,
  ProfileScreen,
  StayInTouchScreen
}
final pageTitles = [
  'Ahed',
  'Settings',
  'Cases',
  'Create Case',
  'Donate',
  'Donate',
  'My Donations',
  'Profile',
  'Our Society',
];

final pageOptions = [
  HomeScreen(),
  SettingsScreen(),
  NeediesScreen(),
  NeedyCreationScreen(),
  OnlineTransactionCreationScreen(),
  OfflineTransactionCreationScreen(),
  MyDonationScreen(),
  ProfileScreen(),
  StayInTouchScreen(),

];