// import 'package:ahed/Session/session_manager.dart';
// import 'package:ahed/Shared%20Data/app_language.dart';
// import 'package:ahed/Shared%20Data/app_theme.dart';
// import 'package:ahed/Shared%20Data/common_data.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
// import 'package:provider/provider.dart';
//
// import '../GeneralInfo.dart';
//
// class DrawerScreen extends StatefulWidget {
//   @override
//   _DrawerScreenState createState() => _DrawerScreenState();
// }
//
// class _DrawerScreenState extends State<DrawerScreen> {
//   SessionManager sessionManager = new SessionManager();
//   CommonData commonData;
//   AppTheme appTheme;
//   AppLanguage appLanguage;
//   @override
//   Widget build(BuildContext context) {
//     commonData = Provider.of<CommonData>(context);
//     appTheme = Provider.of<AppTheme>(context);
//     appLanguage = Provider.of<AppLanguage>(context);
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//       padding: EdgeInsets.only(
//         top: MediaQuery.of(context).size.height / 10,
//       ),
//       decoration: BoxDecoration(
//         color: appTheme.themeData.primaryColor,
//         // image: DecorationImage(
//         //     image: AssetImage(appTheme.isDark
//         //         ? 'assets/images/istockphoto-1085096164-170667a.jpg'
//         //         : 'assets/images/istockphoto-684841716-1024x1024.jpg'),
//         //     fit: BoxFit.cover)
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               SizedBox(width: MediaQuery.of(context).size.width / 50),
//               CircleAvatar(
//                 radius: 30,
//                 backgroundColor: Colors.transparent,
//                 child: ClipOval(
//                   child: Image.network(
//                     sessionManager.user.image,
//                     fit: BoxFit.fill,
//                     width: 120,
//                     height: 120,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width / 50,
//               ),
//               Text.rich(
//                 TextSpan(text: 'Mahmoued\n', children: [
//                   TextSpan(
//                       text: 'CEO',
//                       style: appTheme.themeData.primaryTextTheme.subtitle2)
//                 ]),
//                 style: appTheme.themeData.primaryTextTheme.headline1,
//               ),
//               ElevatedButton(
//                 style: ButtonStyle(
//                   backgroundColor:
//                   MaterialStateProperty.all<Color>(Colors.transparent),
//                   elevation: MaterialStateProperty.all<double>(0.0)
//                 ),
//                 onPressed: () {
//                   sessionManager.logout();
//                   Navigator.popAndPushNamed(context, "LoginScreen");
//                 },
//                 child: Icon(
//                   Entypo.log_out,
//                   //             // AntDesign.logout,
//                   //   // Icons.logout,
//                   size: 20,
//                   color: Colors.red,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height / 10,
//           ),
//           ElevatedButton.icon(
//             label: Text(
//               'Home',
//               style: commonData.step == Pages.HomeScreen.index ||
//                       commonData.step == Pages.NeediesScreen.index
//                   ? appTheme.themeData.primaryTextTheme.subtitle1
//                   : appTheme.themeData.primaryTextTheme.subtitle2,
//             ),
//             icon: Icon(
//               Icons.home,
//               size: 30,
//               color: commonData.step == Pages.HomeScreen.index ||
//                       commonData.step == Pages.NeediesScreen.index
//                   ? appTheme.themeData.primaryTextTheme.subtitle1.color
//                   : appTheme.themeData.primaryTextTheme.subtitle2.color,
//             ),
//             style: ButtonStyle(
//                 backgroundColor:
//                 MaterialStateProperty.all<Color>(Colors.transparent),
//                 elevation: MaterialStateProperty.all<double>(0.0)
//             ),
//             onPressed: () {
//               commonData.changeStep(Pages.HomeScreen.index);
//               commonData.changeScaleCondition(context);
//             },
//           ),
//           ElevatedButton.icon(
//             label: Text(
//               'Profile',
//               style: commonData.step == Pages.ProfileScreen.index
//                   ? appTheme.themeData.primaryTextTheme.subtitle1
//                   : appTheme.themeData.primaryTextTheme.subtitle2,
//             ),
//             icon: Icon(
//               Icons.account_circle,
//               size: 20,
//               color: commonData.step == Pages.ProfileScreen.index
//                   ? appTheme.themeData.primaryTextTheme.subtitle1.color
//                   : appTheme.themeData.primaryTextTheme.subtitle2.color,
//             ),
//             style: ButtonStyle(
//                 backgroundColor:
//                 MaterialStateProperty.all<Color>(Colors.transparent),
//                 elevation: MaterialStateProperty.all<double>(0.0)
//             ),
//             onPressed: () {
//               commonData.changeStep(Pages.ProfileScreen.index);
//               commonData.changeScaleCondition(context);
//             },
//           ),
//           ElevatedButton.icon(
//             label: Text(
//               'Settings',
//               style: commonData.step == Pages.SettingsScreen.index
//                   ? appTheme.themeData.primaryTextTheme.subtitle1
//                   : appTheme.themeData.primaryTextTheme.subtitle2,
//             ),
//             icon: Icon(
//               Icons.settings,
//               size: 20,
//               color: commonData.step == Pages.SettingsScreen.index
//                   ? appTheme.themeData.primaryTextTheme.subtitle1.color
//                   : appTheme.themeData.primaryTextTheme.subtitle2.color,
//             ),
//             style: ButtonStyle(
//                 backgroundColor:
//                 MaterialStateProperty.all<Color>(Colors.transparent),
//                 elevation: MaterialStateProperty.all<double>(0.0)
//             ),
//             onPressed: () {
//               // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen(),));
//               commonData.changeStep(Pages.SettingsScreen.index);
//               commonData.changeScaleCondition(context);
//             },
//           ),
//           ElevatedButton.icon(
//             label: Text(
//               'Stay In Touch',
//               style: commonData.step == Pages.StayInTouchScreen.index
//                   ? appTheme.themeData.primaryTextTheme.subtitle1
//                   : appTheme.themeData.primaryTextTheme.subtitle2,
//             ),
//             icon: Icon(
//               Icons.wifi_protected_setup,
//               size: 20,
//               color: commonData.step == Pages.StayInTouchScreen.index
//                   ? appTheme.themeData.primaryTextTheme.subtitle1.color
//                   : appTheme.themeData.primaryTextTheme.subtitle2.color,
//             ),
//             style: ButtonStyle(
//                 backgroundColor:
//                 MaterialStateProperty.all<Color>(Colors.transparent),
//                 elevation: MaterialStateProperty.all<double>(0.0)
//             ),
//             onPressed: () {
//               commonData.changeStep(Pages.StayInTouchScreen.index);
//               commonData.changeScaleCondition(context);
//             },
//           ),
//           ElevatedButton.icon(
//               style: ButtonStyle(
//                   backgroundColor:
//                   MaterialStateProperty.all<Color>(Colors.transparent),
//                   elevation: MaterialStateProperty.all<double>(0.0),
//                 shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(30))))
//               ),
//               onPressed: () {},
//               icon: Icon(
//                 Icons.warning,
//                 size: 20,
//                 color: Colors.red,
//               ),
//               label: Text('Report a problem',
//                   style: TextStyle(color: Colors.red, fontSize: 15))),
//           Expanded(
//             child: Container(
//               margin: EdgeInsets.only(
//                   top: MediaQuery.of(context).size.height / 10,
//                   left: MediaQuery.of(context).size.width / 4 -
//                       MediaQuery.of(context).size.width / 8),
//               child: Image.asset(
//                 'assets/images/ogive_version_2.png',
//                 width: MediaQuery.of(context).size.width / 8,
//                 height: MediaQuery.of(context).size.height / 10,
//                 fit: BoxFit.contain,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
