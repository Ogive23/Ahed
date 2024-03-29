// ignore_for_file: use_build_context_synchronously

import 'package:ahed/ApiCallers/NeedyApiCaller.dart';
import 'package:ahed/Helpers/Helper.dart';
import 'package:ahed/Models/Needy.dart';
import 'package:ahed/Models/OnlineTransaction.dart';
import 'package:ahed/Shared%20Data/app_language.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'CustomSpacing.dart';
import 'package:ahed/Custom Widgets/NeedyInfoDialog.dart';

class CustomOnlineTransactionTimelineTile extends StatelessWidget {
  final OnlineTransaction transaction;
  static late AppTheme appTheme;
  static late AppLanguage appLanguage;
  //ToDo: Ahed v2 prize
  final bool done;
  final Helper helper = Helper();
  static late double w, h;

  CustomOnlineTransactionTimelineTile(
      {required this.transaction, required this.done});

  showNeedyDialog(context, Needy needy) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return NeedyInfoDialog(
          needy: needy,
          appTheme: appTheme,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    appTheme = Provider.of<AppTheme>(context);
    appLanguage = Provider.of<AppLanguage>(context);
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.5,
      beforeLineStyle:
          LineStyle(color: Colors.black.withOpacity(0.1), thickness: 3),
      indicatorStyle: IndicatorStyle(
        indicatorXY: 0.3, iconStyle: IconStyle(iconData: FontAwesomeIcons.leaf),
        drawGap: true,
        width: 30,
        // height: 30,
        indicator: Container(
          margin: const EdgeInsets.only(left: 13),
          width: 20,
          decoration: BoxDecoration(
              color: done ? Colors.green : Colors.grey,
              borderRadius:
                  const BorderRadius.only(bottomRight: Radius.circular(30))),
        ),
      ),
      startChild: Center(
        child: Container(
          alignment: const Alignment(0.0, -0.50),
          child: Text(
            helper.getAppropriateText(
                intl.DateFormat('y/MM/dd').format(transaction.createdAt)),
            style: appTheme.themeData.primaryTextTheme.headlineMedium,
          ),
        ),
      ),
      endChild: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 10, top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${transaction.amount.toStringAsFixed(2)} جنيه مصري',
              style: appTheme.themeData.primaryTextTheme.headlineSmall!
                  .apply(fontWeightDelta: 2),
            ),
            const CustomSpacing(value: 100),
            GestureDetector(
                    onTap: () async {
                      showNeedyDialog(context, transaction.needy);
                    },
                    child: Text(
                      'عرض الحالة المرتبطة',
                      style: appTheme.themeData.primaryTextTheme.headlineSmall!
                          .apply(
                              decoration: TextDecoration.underline,
                              color: Colors.blue),
                    )),
          ],
        ),
      ),
    );
  }
}
