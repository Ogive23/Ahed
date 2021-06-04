import 'dart:ui';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:ahed/Shared%20Data/common_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomHomeOption extends StatefulWidget {
  final Map<String, dynamic> homeOption;
  CustomHomeOption({@required this.homeOption});
  @override
  _CustomHomeOptionState createState() => _CustomHomeOptionState();
}

class _CustomHomeOptionState extends State<CustomHomeOption>
    with TickerProviderStateMixin {
  static CommonData commonData;
  static AppTheme appTheme;
  static double w, h;
  static AnimationController controller;
  static Animation<double> animation;
  @override
  initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut)
      ..addStatusListener((status) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    commonData = Provider.of<CommonData>(context);
    appTheme = Provider.of<AppTheme>(context);
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    controller.forward();
    return FadeTransition(
        opacity: animation,
        child: GestureDetector(
          onTap: () {
            commonData.changeStep(widget.homeOption['page']);
          },
          child: Container(
            width: w / 2,
            // padding: EdgeInsets.only(bottom: h / 50),
            margin:
                EdgeInsets.symmetric(vertical: h / 100, horizontal: w / 100),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
                color: Colors.black.withOpacity(0.5)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  child: Image.asset(
                    widget.homeOption['image'],
                    height: h / 3,
                    width: w - w / 20,
                    fit: BoxFit.cover,
                    colorBlendMode: BlendMode.darken,
                    color: Colors.blue[500].withOpacity(0.3),
                  ),
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30), bottom: Radius.circular(10)),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30), bottom: Radius.circular(10)),
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                      child: Visibility(
                        child: Container(
                            alignment: Alignment.bottomCenter,
                            padding: EdgeInsets.only(bottom: h / 100),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30),
                                  bottom: Radius.circular(10)),
                            ),
                            height: h / 3,
                            width: w - w / 20,
                            child: Text(
                              widget.homeOption['title'],
                              style: appTheme.nonStaticGetTextStyle(
                                  1.0,
                                  Colors.white,
                                  appTheme.getTextTheme(context),
                                  FontWeight.w600,
                                  1.0,
                                  TextDecoration.none,
                                  'OpenSans'),
                            )),
                        visible: animation.isCompleted,
                      )),
                )
              ],
            ),
          ),
        ));
  }
}
