import 'package:ahed/Shared%20Data/app_language.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:ahed/Shared%20Data/common_data.dart';
import 'package:ahed/Shared%20Data/NeedyData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'FawryPaymentScreen.dart';

class OnlineTransactionCreationScreen extends StatefulWidget {
  @override
  _OnlineTransactionCreationScreenState createState() =>
      _OnlineTransactionCreationScreenState();
}

class _OnlineTransactionCreationScreenState
    extends State<OnlineTransactionCreationScreen>
    with TickerProviderStateMixin {
  double w, h;
  CommonData commonData;
  NeedyData needyData;
  AppLanguage appLanguage;
  AppTheme appTheme;
  TabController tabController;

  @override
  initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    commonData = Provider.of<CommonData>(context);
    needyData = Provider.of<NeedyData>(context);
    appTheme = Provider.of<AppTheme>(context);
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () => commonData.back(),
              icon: Icon(
                Icons.arrow_back_ios_sharp,
                color: Colors.white,
              )),
          title: Text(
            'Donate',
            style: appTheme.nonStaticGetTextStyle(
                1.0,
                Colors.white,
                appTheme.getTextTheme(context),
                FontWeight.w600,
                1.0,
                TextDecoration.none,
                'Delius'),
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(38, 92, 126, 1.0),
          elevation: 0.0),
      backgroundColor: Color.fromRGBO(38, 92, 126, 1.0),
      body: Container(
        child: Column(
          children: [
            TabBar(
              onTap: (value) {
                setState(() {});
              },
              tabs: [
                Tab(
                    icon: Image.asset(
                  'assets/images/8468Image.jpg',
                  width: w / 5,
                )),
                Tab(
                  icon: Image.asset(
                    'assets/images/paypal_logo.png',
                    width: w / 5,
                  ),
                )
              ],
              controller: tabController,
              indicatorColor: Colors.greenAccent,
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
            Expanded(
              child: TabBarView(
                children: [
                  FawryPaymentScreen(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: w / 10),
                    width: w,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Center(
                        child: Center(
                      child: Text('Soon.'),
                    )),
                  ),
                ],
                controller: tabController,
              ),
            )
          ],
        ),
      ),
    );
  }
}
