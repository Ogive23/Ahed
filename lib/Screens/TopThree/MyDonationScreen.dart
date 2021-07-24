import 'package:ahed/ApiCallers/UserApiCaller.dart';
import 'package:ahed/Custom%20Widgets/CustomLoading.dart';
import 'package:ahed/Custom%20Widgets/CustomOfflineTransactionTimelineTile.dart';
import 'package:ahed/Custom%20Widgets/CustomOnlineTransactionTimelineTile.dart';
import 'package:ahed/Custom%20Widgets/CustomSpacing.dart';
import 'package:ahed/Helpers/DataMapper.dart';
import 'package:ahed/Session/session_manager.dart';
import 'package:ahed/Shared%20Data/app_language.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:ahed/Shared%20Data/common_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ahed/Models/Transaction.dart';
import 'package:ahed/Models/OnlineTransaction.dart';
import 'package:ahed/Models/OfflineTransaction.dart';

class MyDonationScreen extends StatefulWidget {
  @override
  _MyDonationScreenState createState() => _MyDonationScreenState();
}

class _MyDonationScreenState extends State<MyDonationScreen>
    with TickerProviderStateMixin {
  late double w, h;
  late CommonData commonData;
  late AppLanguage appLanguage;
  late AppTheme appTheme;
  late List<Transaction> transactions;
  late TabController tabController;
  late UserApiCaller userApiCaller = new UserApiCaller();
  final DataMapper dataMapper = new DataMapper();

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
  Future<Map<String, dynamic>> getOnlineTransactions() async {
    return await userApiCaller.getOnlineTransactions(sessionManager.user!.id);
  }

  Future<Map<String, dynamic>> getOfflineTransactions() async {
    return await userApiCaller.getOfflineTransactions(sessionManager.user!.id);
  }

  Widget getOnlineTransactionsBody(context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getOnlineTransactions(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null &&
            !snapshot.data!['Err_Flag']) {
          // return Expanded(
          return SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:
                    //ToDo: Ahed V2 When adding Prize
                    // <Widget>[
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
                    // ] +
                    getOnlineTimeLine(snapshot.data!['Values'])
                //   ),
                ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null &&
            snapshot.data!['Err_Flag']) {
          print(snapshot.data);
          return Container(
            alignment: Alignment.center,
            child: Text('${snapshot.data!['Err_Desc']}'),
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

  Widget getOfflineTransactionsBody(context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getOfflineTransactions(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null &&
            !snapshot.data!['Err_Flag']) {
          // return Expanded(
          return SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:
                    //ToDo: Ahed V2 When adding Prize
                    // <Widget>[
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
                    // ] +
                    getOfflineTimeLine(snapshot.data!['Values'])
                //   ),
                ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null &&
            snapshot.data!['Err_Flag']) {
          print(snapshot.data);
          return Container(
            alignment: Alignment.center,
            child: Text('${snapshot.data!['Err_Desc']}'),
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
                    ? getOnlineTransactionsBody(context)
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
                    ? getOfflineTransactionsBody(context)
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

  List<Widget> getOnlineTimeLine(List<Transaction> transactions) {
    List<Widget> transactionWidgets = [];
    print(transactions);
    transactions.forEach((transaction) {
      transactionWidgets.add(CustomOnlineTransactionTimelineTile(
          done: true, transaction: transaction as OnlineTransaction));
    });
    print(transactionWidgets.length);
    // if (remainingUntilPrize != 0) {
    //   transactionWidgets.add(CustomTimelineTile(done: false));
    // }
    return transactionWidgets.reversed.toList();
  }

  List<Widget> getOfflineTimeLine(List<Transaction> transactions) {
    List<Widget> transactionWidgets = [];
    print(transactions);
    transactions.forEach((transaction) {
      transactionWidgets.add(CustomOfflineTransactionTimelineTile(
          done: true, transaction: transaction as OfflineTransaction));
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
