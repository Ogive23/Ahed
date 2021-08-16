import 'package:ahed/Custom%20Widgets/CustomSpacing.dart';
import 'package:ahed/Shared%20Data/app_language.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:ahed/Shared%20Data/common_data.dart';
import 'package:ahed/Shared%20Data/NeedyData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
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
  late double w, h;
  late CommonData commonData;
  late NeedyData needyData;
  late AppLanguage appLanguage;
  late AppTheme appTheme;
  late TabController tabController;
  ScrollController scrollController = new ScrollController();
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
          actions: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: IconButton(
                  onPressed: () => commonData.back(),
                  icon: Icon(
                    Icons.arrow_back_ios_sharp,
                    color: appTheme.themeData.appBarTheme.iconTheme!.color,
                  )),
            )
          ],
          title: Padding(
              padding: EdgeInsets.only(top: h / 20, bottom: h / 40),
              child: Text(
                'تبرع',
                style: appTheme.themeData.primaryTextTheme.headline2,
              )),
          backgroundColor: appTheme.themeData.primaryColor,
          elevation: 0.0),
      backgroundColor: appTheme.themeData.primaryColor,
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: w / 10, right: w / 10, top: h / 100, bottom: h / 200),
              width: w,
              height: h / 4,
              // height: double.infinity
              child: Scrollbar(
                controller: scrollController,
                isAlwaysShown: true,
                hoverThickness: 4.5,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('أسم الحالة: ',
                              style: appTheme
                                  .themeData.primaryTextTheme.headline5),
                          Flexible(
                            child: Text('${needyData.selectedNeedy!.name}',
                                style: appTheme
                                    .themeData.primaryTextTheme.headline5),
                          ),
                        ],
                      ),
                      CustomSpacing(
                        value: 100,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('نوع الحالة: ',
                              style: appTheme
                                  .themeData.primaryTextTheme.headline5),
                          Flexible(
                            child: Text('${needyData.selectedNeedy!.type}',
                                style: appTheme
                                    .themeData.primaryTextTheme.headline5),
                          ),
                        ],
                      ),
                      CustomSpacing(
                        value: 100,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight: h/8,
                            minHeight: h/10
                        ),
                        child: SingleChildScrollView(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('التفاصيل: ',
                                  style: appTheme
                                      .themeData.primaryTextTheme.headline5),
                              Flexible(
                                child: Text(
                                  '${needyData.selectedNeedy!.details}',
                                  style: appTheme
                                      .themeData.primaryTextTheme.headline5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomSpacing(
                        value: 100,
                      ),
                      Row(
                        children: [
                          Text('مسار النجاح: ',
                              style: appTheme
                                  .themeData.primaryTextTheme.headline5),
                          LinearPercentIndicator(
                            width: w / 2,
                            alignment: MainAxisAlignment.center,
                            animation: true,
                            padding: EdgeInsets.symmetric(vertical: h / 100),
                            animationDuration: 1000,
                            lineHeight: h / 25,
                            linearGradient: LinearGradient(
                                colors: [Colors.green, Colors.greenAccent]),
                            percent: needyData.selectedNeedy!.collected! /
                                needyData.selectedNeedy!.need!,
                            center: Text(
                              (needyData.selectedNeedy!.need! -
                                          needyData.selectedNeedy!.collected!)
                                      .toStringAsFixed(0) +
                                  ' جنيه متبقي',
                              style:
                                  appTheme.themeData.primaryTextTheme.bodyText2,
                            ),
                            linearStrokeCap: LinearStrokeCap.butt,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CustomSpacing(value: 100),
            TabBar(
              // onTap: (value) {
              //   // setState(() {});
              // },
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
