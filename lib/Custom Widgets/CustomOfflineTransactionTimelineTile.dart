import 'package:ahed/ApiCallers/NeedyApiCaller.dart';
import 'package:ahed/Helpers/Helper.dart';
import 'package:ahed/Models/OfflineTransaction.dart';
import 'package:ahed/Screens/NeediesScreens/ShowNeedyScreen.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CustomOfflineTransactionTimelineTile extends StatelessWidget {
  final OfflineTransaction transaction;
  static late AppTheme appTheme;
  //ToDo: Ahed v2 prize
  final bool done;
  final Helper helper = new Helper();
  CustomOfflineTransactionTimelineTile(
      {required this.transaction, required this.done});
  @override
  Widget build(BuildContext context) {
    appTheme = Provider.of<AppTheme>(context);
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
                DateFormat('y/MM/dd').format(transaction.createdAt)),
            style: TextStyle(
              fontSize: 16,
              color: Colors.black.withOpacity(0.6),
              fontWeight: FontWeight.w800,
            ),
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
              style: TextStyle(
                fontSize: 18,
                color: Colors.black.withOpacity(0.8),
                fontWeight: FontWeight.bold,
              ),
            ),
            transaction.needy == null
                ? Text(
                    'تبرعك ذهب إلي جهة ${helper.getAppropriateText(transaction.preferredSection)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.6),
                      fontWeight: FontWeight.normal,
                    ),
                  )
                : GestureDetector(
                    onTap: () async {
                      NeedyApiCaller needyApiCaller = new NeedyApiCaller();
                      Map<String, dynamic> status =
                          await needyApiCaller.getById(transaction.needy!);
                      if (!status['Err_Flag'])
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowNeedyScreen(
                                needy: status['Value'],
                                appTheme: appTheme,
                              ),
                            ));
                    },
                    child: Text('عرض الحالة المرتبطة')),
            transaction.collected
                ? SizedBox()
                : transaction.selectedDate != null
                    ? Text(
                        'سيصل مندوبنا يوم ${helper.getAppropriateText(DateFormat('y/MM/dd').format(transaction.selectedDate!))}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    : Column(
                        children: [
                          Text('سيتم التواصل معكم قريباً'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  
                                },
                                child: Text(
                                  'تعديل',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blue.withOpacity(0.6),
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'حذف',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.red.withOpacity(0.6),
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.underline),
                                ),
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
