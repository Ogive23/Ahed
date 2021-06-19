import 'package:ahed/Custom%20Widgets/CustomLoading.dart';
import 'package:ahed/Custom%20Widgets/CustomSpacing.dart';
import 'package:ahed/GeneralInfo.dart';
import 'package:ahed/Session/session_manager.dart';
import 'package:ahed/Shared%20Data/app_language.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:ahed/Shared%20Data/common_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:ahed/Models/Transaction.dart';
import 'package:ahed/Models/OnlineTransaction.dart';
import 'package:ahed/Models/OfflineTransaction.dart';
import 'package:ahed/Custom Widgets/CustomTimelineTile.dart';

class MyDonationScreen extends StatefulWidget {
  @override
  _MyDonationScreenState createState() => _MyDonationScreenState();
}

class _MyDonationScreenState extends State<MyDonationScreen>
    with TickerProviderStateMixin {
  double w, h;
  CommonData commonData;
  AppLanguage appLanguage;
  AppTheme appTheme;
  List<Transaction> transactions;
  TabController tabController;

  SessionManager sessionManager = new SessionManager();
  @override
  initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
  }

  //ToDo: Ahed V2 When adding Prize
  // double remainingUntilPrize;
  // String prize;
  // String prizeImage;
  Future<Map<String, dynamic>> getTransactions(type) async {
    // await Future.delayed(Duration(seconds: 4));
    return {
      //ToDo: Ahed V2 When adding Prize
      // "remainingUntilPrize": 900.5,
      // "prize": "Vivo Y73",
      "transactions": type == "Online"
          ? [
              OnlineTransaction('4', '1', '4', 64, DateTime(2020, 8, 27),
                  'OnlineTransaction', 0),
              OnlineTransaction('4', '1', '4', 64, DateTime(2020, 8, 27),
                  'OnlineTransaction', 0),
              OnlineTransaction('3', '1', '3', 312, DateTime(2021, 01, 07),
                  'OnlineTransaction', 0),
              OnlineTransaction('2', '1', '2', 157, DateTime(2021, 2, 24),
                  'OnlineTransaction', 0),
              OnlineTransaction('1', '1', '1', 133, DateTime(2021, 04, 09),
                  'OnlineTransaction', 0),
            ]
          : [
              OfflineTransaction(
                  '2',
                  '1',
                  null,
                  34,
                  DateTime(2020, 11, 17),
                  'OfflineTransaction',
                  'إيجاد مسكن مناسب',
                  'El gesr Elbrany St',
                  DateTime(2020, 11, 17),
                  DateTime(2020, 11, 21),
                  DateTime(2020, 11, 20),
                  true),
              OfflineTransaction(
                  '1',
                  '1',
                  '1',
                  35,
                  DateTime(2021, 03, 03),
                  'OfflineTransaction',
                  'تجهيز العرائس',
                  'El gesr Elbrany St',
                  DateTime(2021, 03, 03),
                  DateTime(2021, 03, 07),
                  DateTime(2021, 03, 03),
                  true),
            ]
    };
  }

  Widget getTransactionsBody(context, String type) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getTransactions(type),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          print(snapshot.data);
          transactions = snapshot.data['transactions'];
          // return Expanded(
          return SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                      //ToDo: Ahed V2 When adding Prize
                      // TimelineTile(
                      //   alignment: TimelineAlign.manual,
                      //   lineXY: 0.3,
                      //   isFirst: true,
                      //   indicatorStyle: IndicatorStyle(
                      //     width: 70,
                      //     height: 70,
                      //     indicator:
                      //         Image.asset('assets/images/gift-png.png'),
                      //   ),
                      //   beforeLineStyle:
                      //       LineStyle(color: Colors.black.withOpacity(0.7)),
                      //   endChild: ContainerHeader(
                      //     prize: snapshot.data['prize'],
                      //     prizeImage: prizeImage,
                      //     remainingUntilPrize: snapshot.data['remainingUntilPrize'],
                      //   ),
                      // ),
                    ] +
                    getTimeLine(transactions)
                //   ),
                ),
          );
        } else if (snapshot.error != null) {
          return Container(
            alignment: Alignment.center,
            child: Text(
                'Error Showing Transactions, Please Restart ${snapshot.error}'),
          );
        } else {
          return Container(alignment: Alignment.center, child: CustomLoading());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    commonData = Provider.of<CommonData>(context);
    appTheme = Provider.of<AppTheme>(context);
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Padding(
          padding: EdgeInsets.only(top: h / 20),
          child: Text(
            'تبرعاتي',
            style: appTheme.nonStaticGetTextStyle(
                1.0,
                Colors.black,
                appTheme.getTextTheme(context) * 1.5,
                FontWeight.w600,
                1.0,
                TextDecoration.none,
                'Delius'),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(children: [
          CustomSpacing(),
          CustomSpacing(),
          CustomSpacing(),
          TabBar(
            tabs: [
              Tab(
                  child: Text(
                'الدفع الإلكتروني',
                style: appTheme.nonStaticGetTextStyle(
                    1.0,
                    Colors.black,
                    appTheme.getSemiBodyTextTheme(context),
                    FontWeight.w600,
                    1.0,
                    TextDecoration.none,
                    'Delius'),
              )),
              Tab(
                  child: Text(
                'الدفع النقدي',
                style: appTheme.nonStaticGetTextStyle(
                    1.0,
                    Colors.black,
                    appTheme.getSemiBodyTextTheme(context),
                    FontWeight.w600,
                    1.0,
                    TextDecoration.none,
                    'Delius'),
              ))
            ],
            controller: tabController,
            indicatorColor: Colors.amber,
            unselectedLabelColor: Colors.grey.withOpacity(0.5),
            unselectedLabelStyle: appTheme.nonStaticGetTextStyle(
                1.0,
                Colors.grey.withOpacity(0.4),
                appTheme.getBodyTextTheme(context),
                FontWeight.w600,
                1.0,
                TextDecoration.none,
                'Delius'),
            labelStyle: appTheme.nonStaticGetTextStyle(
                1.0,
                Colors.black,
                appTheme.getBodyTextTheme(context),
                FontWeight.w600,
                1.0,
                TextDecoration.none,
                'Delius'),
          ),
          CustomSpacing(),
          Expanded(
            child: TabBarView(
              children: [
                sessionManager.isLoggedIn()
                    ? getTransactionsBody(context, 'Online')
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('عليك تسجيل الدخول للمتابعة'),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "LoginScreen");
                            },
                            child: Text(
                              'تسجيل الدخول',
                              style: appTheme.nonStaticGetTextStyle(
                                  1.0,
                                  Colors.blue,
                                  appTheme.getSemiBodyTextTheme(context),
                                  FontWeight.w400,
                                  1.0,
                                  TextDecoration.underline,
                                  'Delius'),
                            ),
                          )
                        ],
                      ),
                sessionManager.isLoggedIn()
                    ? getTransactionsBody(context, 'Offline')
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('عليك تسجيل الدخول للمتابعة'),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "LoginScreen");
                            },
                            child: Text(
                              'تسجيل الدخول',
                              style: appTheme.nonStaticGetTextStyle(
                                  1.0,
                                  Colors.blue,
                                  appTheme.getSemiBodyTextTheme(context),
                                  FontWeight.w400,
                                  1.0,
                                  TextDecoration.underline,
                                  'Delius'),
                            ),
                          )
                        ],
                      ),
              ],
              controller: tabController,
            ),
          )
        ]),
      ),
    );
  }

  List<Widget> getTimeLine(List<Transaction> transactions) {
    List<Widget> transactionWidgets = [];
    transactions.forEach((transaction) {
      transactionWidgets.add(CustomTimelineTile(
          done: true,
          time: transaction.createdAt,
          amount: transaction.amount,
          text: transaction.type == 'OfflineTransaction'
              ? 'تبرعك ذهب إلي جهة ' +
                  (transaction as OfflineTransaction).preferredSection
              : ''));
    });
    print(transactionWidgets.length);
    // if (remainingUntilPrize != 0) {
    //   transactionWidgets.add(CustomTimelineTile(done: false));
    // }
    return transactionWidgets.reversed.toList();
  }
}

//ToDo: Ahed V2 When adding Prize
// class ContainerHeader extends StatelessWidget {
//   final double remainingUntilPrize;
//   final String prize;
//   final String prizeImage;
//   ContainerHeader(
//       {@required this.remainingUntilPrize,
//       @required this.prize,
//       @required this.prizeImage});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: const BoxConstraints(minHeight: 120),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: <Widget>[
//             Text(
//               '$remainingUntilPrize EGP Left',
//               style: TextStyle(
//                 fontSize: 18,
//                 color: const Color(0xFFF4A5CD),
//               ),
//             ),
//             Text(
//               'Prize: $prize',
//               style: TextStyle(
//                 fontSize: 25,
//                 color: Colors.black.withOpacity(0.8),
//                 fontWeight: FontWeight.w800,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
