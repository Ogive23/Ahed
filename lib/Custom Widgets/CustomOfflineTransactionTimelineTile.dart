import 'package:ahed/ApiCallers/NeedyApiCaller.dart';
import 'package:ahed/ApiCallers/TransactionApiCaller.dart';
import 'package:ahed/Custom%20Widgets/CustomSpacing.dart';
import 'package:ahed/Helpers/Helper.dart';
import 'package:ahed/Models/Needy.dart';
import 'package:ahed/Models/OfflineTransaction.dart';
import 'package:ahed/Session/session_manager.dart';
import 'package:ahed/Shared%20Data/NeedyData.dart';
import 'package:ahed/Shared%20Data/TransactionData.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:ahed/Shared%20Data/common_data.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../GeneralInfo.dart';
import 'package:ahed/Custom Widgets/NeedyInfoDialog.dart';

class CustomOfflineTransactionTimelineTile extends StatelessWidget {
  final OfflineTransaction transaction;
  static late AppTheme appTheme;
  static late CommonData commonData;
  static late NeedyData needyData;
  static late TransactionData transactionData;
  //ToDo: Ahed v2 prize
  final bool done;
  final Helper helper = new Helper();
  static late double w, h;
  Function callBack;

  CustomOfflineTransactionTimelineTile(
      {required this.transaction, required this.done, required this.callBack});

  showNeedyDialog(context, Needy needy) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return NeedyInfoDialog(needy: needy,appTheme: appTheme,);
      },
    );
  }

  onDeleteSelected(context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: appTheme.themeData.cardColor,
            titlePadding:
                EdgeInsets.symmetric(horizontal: w / 50, vertical: h / 50),
            contentPadding:
                EdgeInsets.symmetric(horizontal: w / 25, vertical: h / 50),
            title: Text(
              'هل تريد حذف هذا التبرع؟',
              style: appTheme.themeData.primaryTextTheme.headline5,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'نعم',
                  style: TextStyle(color: Colors.white),
                ),
                shape: Border.all(color: Colors.white),
                color: Colors.green,
                onPressed: () async {
                  TransactionApiCaller transactionApiCaller =
                      new TransactionApiCaller();
                  SessionManager sessionManager = new SessionManager();
                  Map<String, dynamic> status =
                      await transactionApiCaller.deleteOfflineTransactions(
                          sessionManager.user!.id, transaction.id);
                  Navigator.of(dialogContext).pop();
                  if (status['Err_Flag']) {
                    return CoolAlert.show(
                        context: context,
                        type: CoolAlertType.error,
                        lottieAsset: 'assets/animations/38213-error.json',
                        text: status['Err_Desc'],
                        confirmBtnColor: Color(0xff1c9691),
                        title: '');
                  } else {
                    // commonData.back();
                    callBack();
                    return CoolAlert.show(
                        context: context,
                        type: CoolAlertType.success,
                        lottieAsset: 'assets/animations/6951-success.json',
                        text: status['message'],
                        confirmBtnColor: Color(0xff1c9691),
                        title: '');
                  }
                },
              ),
              FlatButton(
                child: Text(
                  'لا',
                  style: TextStyle(color: Colors.white),
                ),
                shape: Border.all(color: Colors.white),
                color: Colors.red,
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    appTheme = Provider.of<AppTheme>(context);
    commonData = Provider.of<CommonData>(context);
    needyData = Provider.of<NeedyData>(context);
    transactionData = Provider.of<TransactionData>(context);

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
          margin: EdgeInsets.only(left: 13),
          width: 20,
          decoration: BoxDecoration(
              color: transaction.collected ? Colors.green : Colors.grey,
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(30))),
        ),
      ),
      startChild: Center(
        child: Container(
          alignment: const Alignment(0.0, -0.50),
          child: Text(
            helper.getAppropriateText(
                intl.DateFormat('y/MM/dd').format(transaction.createdAt)),
            style: appTheme.themeData.primaryTextTheme.headline4,
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
              transaction.amount.toStringAsFixed(2) + " جنيه مصري",
              style: appTheme.themeData.primaryTextTheme.headline5!
                  .apply(fontWeightDelta: 2),
            ),
            CustomSpacing(value: 100),
            transaction.needy == null
                ? Text(
                    'تبرعك ذهب إلي جهة ${helper.getAppropriateText(transaction.preferredSection)}',
                    style: appTheme.themeData.primaryTextTheme.headline5,
                  )
                : GestureDetector(
                    onTap: () async {
                      CoolAlert.show(
                          context: context,
                          type: CoolAlertType.loading,
                          lottieAsset: 'assets/animations/890-loading-animation.json',
                          text: 'جاري تحميل بيانات الحالة',
                          // confirmBtnColor: Color(0xff1c9691),
                          title: '');
                      NeedyApiCaller needyApiCaller = new NeedyApiCaller();
                      Map<String, dynamic> status =
                          await needyApiCaller.getById(transaction.needy!);
                      Navigator.pop(context);
                      if (!status['Err_Flag']) {
                        showNeedyDialog(context, status['Value']);
                      } else {
                        return CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            lottieAsset:
                            'assets/animations/38213-error.json',
                            text: status['Err_Desc'],
                            confirmBtnColor: Color(0xff1c9691),
                            title: '');
                      }

                    },
                    child: Text(
                      'عرض الحالة المرتبطة',
                      style: appTheme.themeData.primaryTextTheme.headline5!
                          .apply(
                              decoration: TextDecoration.underline,
                              color: Colors.blue),
                    )),
            CustomSpacing(value: 100),
            transaction.collected
                ? SizedBox()
                : transaction.selectedDate != null
                    ? Text(
                        'سيصل مندوبنا يوم ${helper.getAppropriateText(intl.DateFormat('y/MM/dd').format(transaction.selectedDate!))}',
                        style: appTheme.themeData.primaryTextTheme.headline5)
                    : Column(
                        children: [
                          Text('سيتم التواصل معكم قريباً',
                              style: appTheme
                                  .themeData.primaryTextTheme.headline5),
                          CustomSpacing(value: 100),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  NeedyApiCaller needyApiCaller =
                                      new NeedyApiCaller();
                                  Map<String, dynamic> status =
                                      await needyApiCaller
                                          .getById(transaction.needy!);
                                  if (!status['Err_Flag']) {
                                    needyData.chooseNeedy(status['Value']);
                                    transactionData
                                        .chooseTransaction(transaction);
                                    commonData.changeStep(Pages
                                        .OfflineTransactionUpdateScreen.index);
                                  } else {
                                    return CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.error,
                                        lottieAsset:
                                            'assets/animations/38213-error.json',
                                        text: status['Err_Desc'],
                                        confirmBtnColor: Color(0xff1c9691),
                                        title: '');
                                  }
                                },
                                child: Text('تعديل',
                                    style: appTheme
                                        .themeData.primaryTextTheme.headline5!
                                        .apply(color: Colors.blue)),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await onDeleteSelected(context);
                                },
                                child: Text('حذف',
                                    style: appTheme
                                        .themeData.primaryTextTheme.headline5!
                                        .apply(color: Colors.red)),
                              ),
                            ],
                          )
                        ],
                      ),
          ],
        ),
      ),
    );
  }
}
