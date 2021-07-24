import 'package:ahed/Helpers/Helper.dart';
import 'package:ahed/Models/OnlineTransaction.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CustomOnlineTransactionTimelineTile extends StatelessWidget {
  final OnlineTransaction transaction;
  //ToDo: Ahed v2 prize
  final bool done;
  final Helper helper = new Helper();
  CustomOnlineTransactionTimelineTile({required this.transaction, required this.done});
  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.5,
      beforeLineStyle: LineStyle(color: Colors.black.withOpacity(0.1),thickness: 3),
      indicatorStyle: IndicatorStyle(
        indicatorXY: 0.3, iconStyle: IconStyle(iconData: FontAwesomeIcons.leaf),
        drawGap: true,
        width: 30,
        // height: 30,
        indicator: Container(
          margin: EdgeInsets.only(left: 13),
          width: 20,
          decoration: BoxDecoration(
              color: done ? Colors.green : Colors.grey,
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(30))),
        ),
      ),
      startChild: Center(
        child: Container(
          alignment: const Alignment(0.0, -0.50),
          child: Text(
                  helper.getAppropriateText(DateFormat('y/MM/dd').format(transaction.createdAt)),
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
            transaction.needy != null?
                Text('لا حالة مرتبطة.'):
                GestureDetector(
                  onTap: () async {

                    // Navigator.push(context, MaterialPageRoute(builder: (context) => ShowNeedyScreen(needy: ),))
                  },
                ),
          ],
        ),
      ),
    );
  }
}
