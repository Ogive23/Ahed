import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CustomTimelineTile extends StatelessWidget {
  final bool done;
  final DateTime time;
  final double amount;
  final String text;
  CustomTimelineTile({this.done, this.time, this.amount, this.text});
  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.5,
      beforeLineStyle: LineStyle(color: Colors.black.withOpacity(0.1),thickness: 3),
      indicatorStyle: IndicatorStyle(
        indicatorXY: 0.3, iconStyle: IconStyle(iconData: Entypo.leaf),
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
          child: time == null
              ? SizedBox()
              : Text(
                  DateFormat('y/MM/dd').format(time),
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
            amount == null
                ? SizedBox()
                : Text(
                    amount.toStringAsFixed(2)+" جنيه مصري",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            const SizedBox(height: 4),
            text == null
                ? SizedBox()
                : Text(
                    text,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.6),
                      fontWeight: FontWeight.normal,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
