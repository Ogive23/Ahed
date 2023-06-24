import 'package:ahed/ApiCallers/TransactionApiCaller.dart';
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
  final DataMapper dataMapper = DataMapper();
  final TransactionApiCaller transactionApiCaller = TransactionApiCaller();
  SessionManager sessionManager = SessionManager();

  @override
  initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  //ToDo: Ahed V2 When adding Prize
  // double remainingUntilPrize;
  // String prize;
  // String prizeImage;
  Future<Map<String, dynamic>> getOnlineTransactions() async {
    return await transactionApiCaller
        .getOnlineTransactions(appLanguage.language!, sessionManager.user!.id);
  }

  Future<Map<String, dynamic>> getOfflineTransactions() async {
    return await transactionApiCaller
        .getOfflineTransactions(appLanguage.language!, sessionManager.user!.id);
  }

  Widget getOnlineTransactionsBody(context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getOnlineTransactions(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null &&
            !snapshot.data!['Err_Flag'] &&
            snapshot.data!['Values'].isNotEmpty) {
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
                ),
          );
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null &&
            !snapshot.data!['Err_Flag'] &&
            snapshot.data!['Values'].isEmpty) {
          // return Expanded(
          return Container(
            alignment: Alignment.center,
            child: Text(
              'لا توجد تبرعات متاحة',
              style: appTheme.themeData.primaryTextTheme.headline4,
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done &&
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
            !snapshot.data!['Err_Flag'] &&
            snapshot.data!['Values'].isNotEmpty) {
          print('finally');
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
                ),
          );
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null &&
            !snapshot.data!['Err_Flag'] &&
            snapshot.data!['Values'].isEmpty) {
          // return Expanded(
          return Container(
            alignment: Alignment.center,
            child: Text(
              'لا توجد تبرعات متاحة',
              style: appTheme.themeData.primaryTextTheme.headline4,
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done &&
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
    appLanguage = Provider.of<AppLanguage>(context);
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: appTheme.themeData.primaryColor,
      appBar: AppBar(
        backgroundColor: appTheme.themeData.primaryColor,
        elevation: 0.0,
        title: Padding(
          padding: EdgeInsets.only(top: h / 20),
          child: Text(
            'تبرعاتي',
            style: appTheme.themeData.primaryTextTheme.headline2,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        child: Column(children: [
          const CustomSpacing(
            value: 33,
          ),
          TabBar(
            tabs: [
              Tab(
                  child: Text(
                'الدفع الإلكتروني',
                style: appTheme.nonStaticGetTextStyle(
                    1.0,
                    appTheme.themeData.primaryTextTheme.headline2!.color,
                    appTheme.mediumTextSize(context),
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
                    appTheme.themeData.primaryTextTheme.headline2!.color,
                    appTheme.mediumTextSize(context),
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
                appTheme.smallTextSize(context),
                FontWeight.w600,
                1.0,
                TextDecoration.none,
                'Delius'),
            // labelStyle: appTheme.nonStaticGetTextStyle(
            //     1.0,
            //     Colors.black,
            //     appTheme.getBodyTextTheme(context),
            //     FontWeight.w600,
            //     1.0,
            //     TextDecoration.none,
            //     'Delius'),
          ),
          const CustomSpacing(
            value: 100,
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                sessionManager.isLoggedIn()
                    ? getOnlineTransactionsBody(context)
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'عليك تسجيل الدخول للمتابعة',
                            style:
                                appTheme.themeData.primaryTextTheme.headline6,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, 'LoginScreen');
                            },
                            child: Text(
                              'تسجيل الدخول',
                              style: appTheme.nonStaticGetTextStyle(
                                  1.0,
                                  Colors.blue,
                                  appTheme.mediumTextSize(context),
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
                          Text(
                            'عليك تسجيل الدخول للمتابعة',
                            style:
                                appTheme.themeData.primaryTextTheme.headline6,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, 'LoginScreen');
                            },
                            child: Text(
                              'تسجيل الدخول',
                              style: appTheme.nonStaticGetTextStyle(
                                  1.0,
                                  Colors.blue,
                                  appTheme.mediumTextSize(context),
                                  FontWeight.w400,
                                  1.0,
                                  TextDecoration.underline,
                                  'Delius'),
                            ),
                          )
                        ],
                      ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  List<Widget> getOnlineTimeLine(List<Transaction> transactions) {
    return transactions
        .map((transaction) => CustomOnlineTransactionTimelineTile(
            done: true, transaction: transaction as OnlineTransaction))
        .toList()
        .reversed
        .toList();
    // if (remainingUntilPrize != 0) {
    //   transactionWidgets.add(CustomTimelineTile(done: false));
    // }
  }

  List<Widget> getOfflineTimeLine(List<Transaction> transactions) {
    return transactions
        .map((transaction) => CustomOfflineTransactionTimelineTile(
            done: true, transaction: transaction as OfflineTransaction,callBack: (){setState((){});}))
        .toList()
        .reversed
        .toList();
    // if (remainingUntilPrize != 0) {
    //   transactionWidgets.add(CustomTimelineTile(done: false));
    // }
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
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
