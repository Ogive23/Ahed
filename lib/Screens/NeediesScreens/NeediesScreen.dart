import 'dart:math';

import 'package:ahed/ApiCallers/NeedyApiCaller.dart';
import 'package:ahed/Custom%20Widgets/CustomLoading.dart';
import 'package:ahed/Custom%20Widgets/CustomNeedyContainer.dart';
import 'package:ahed/Custom%20Widgets/CustomSpacing.dart';
import 'package:ahed/Custom%20Widgets/LoadingNeedyContainer.dart';
import 'package:ahed/Models/Needy.dart';
import 'package:ahed/Models/NeedyMedia.dart';
import 'package:ahed/Shared%20Data/app_language.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:ahed/Shared%20Data/common_data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NeediesScreen extends StatefulWidget {
  @override
  _NeediesScreenState createState() => _NeediesScreenState();
}

class _NeediesScreenState extends State<NeediesScreen> {
  double w, h;
  CommonData commonData;
  AppLanguage appLanguage;
  AppTheme appTheme;
  List<Needy> needies;
  int current = 0;
  TabController tabController;
  @override
  initState() {
    super.initState();
    initNeedies();
  }

  initNeedies() async {
    List<Needy> addedNeedies = await getGeneratedNeedies();
    setState(() {
      needies = [];
      needies.addAll(addedNeedies);
    });
  }

  Widget getNeediesBody(context) {
    print('im here ${needies}');
    if (needies == null)
      return Container(alignment: Alignment.center, child: CustomLoading());
    if (needies.isEmpty)
      return Container(
        child: Text('Empty'),
      );
    return Center(
        child: CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 0.7,
              height: h - h / 4,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) async {
                current = index;
                if (current == needies.length) {
                  List<Needy> addedNeedies = await getGeneratedNeedies();
                  setState(() {
                    needies.addAll(addedNeedies);
                  });
                  print(current);
                }
              },
            ),
            items: <Widget>[] +
                needies
                    .map((needy) => CustomNeedyContainer(needy: needy))
                    .toList() +
                [
                  Visibility(
                    child: LoadingNeedyContainer(),
                    visible: needies.isEmpty || current <= needies.length,
                  )
                ]));
  }

  Future<List<Needy>> getGeneratedNeedies() async {
    NeedyApiCaller needyApiCaller = new NeedyApiCaller();
    Map<String,dynamic> status = await needyApiCaller.getAll();
    print(status);
    if(!status['Err_Flag'])
      return status['Values'];
    //ToDo: Handle Error
    print(status['Err_Flag']);
  }

  @override
  Widget build(BuildContext context) {
    commonData = Provider.of<CommonData>(context);
    appTheme = Provider.of<AppTheme>(context);
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Material(
      color: Colors.blueGrey[200],
      child: SafeArea(
        child: Container(
          height: h,
          width: w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blueGrey[200], Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_sharp,
                      color: Colors.white,
                    ),
                    onPressed: () => commonData.back(),
                  ),
                ],
              ),
              CustomSpacing(),
              Padding(
                padding: EdgeInsets.only(left: w / 10),
                child: Text(
                  'Cases',
                  style: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.white,
                      appTheme.getTextTheme(context) * 1.5,
                      FontWeight.w600,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                ),
              ),
              CustomSpacing(),
              getNeediesBody(context),
            ],
          ),
        ),
      ),
    );
  }

  String getSeverityClass(int severity) {
    if(severity > 0 && severity < 4)
      return 'Low';
    if(severity > 4 && severity < 7)
      return 'Medium';
    return 'High';
  }
}
