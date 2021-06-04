import 'dart:math';

import 'package:ahed/Custom%20Widgets/CustomLoading.dart';
import 'package:ahed/Custom%20Widgets/CustomNeedyContainer.dart';
import 'package:ahed/Custom%20Widgets/CustomSpacing.dart';
import 'package:ahed/Custom%20Widgets/LoadingNeedyContainer.dart';
import 'package:ahed/Models/Needy.dart';
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

  getRandomType(int randomNumber) {
    switch (randomNumber) {
      case 0:
        return 'Finding Living';
      case 1:
        return 'Upgrade Standard of Living';
      case 2:
        return 'Bride Preparation';
      case 3:
        return 'Debt';
      case 4:
        return 'Cure';
    }
  }

  List<String> getRandomImage(int randomNumber) {
    print(randomNumber);
    switch (randomNumber) {
      case 0:
        return ['assets/images/2018_12_05_4268-Edit.jpg'];
      case 1:
        return ['assets/images/319028.jpg'];
      case 2:
        return ['assets/images/images.jpg'];
      case 3:
        return ['assets/images/dept.jpg'];
      case 4:
        return ['assets/images/child-hospital-002.jpg'];
    }
  }

  String getRandomCharity(int randomNumber) {
    print(randomNumber);
    switch (randomNumber) {
      case 0:
        return 'Resala';
      case 1:
        return 'Gamiet El-Br';
      case 2:
        return 'El Jalila';
      case 3:
        return 'Khalaf Ahmad Al Habtoor';
      case 4:
        return 'Magdi Yacoub';
    }
  }

  String getRandomCharityImage(int randomNumber) {
    print(randomNumber);
    switch (randomNumber) {
      case 0:
        return 'assets/images/bSOfYXcD_400x400.png';
      case 1:
        return 'assets/images/dar-al-ber-society.jpg';
      case 2:
        return 'assets/images/1519881695999.png';
      case 3:
        return 'assets/images/khalaf-al-habtoor.jpg';
      case 4:
        return 'assets/images/1519887944403.png';
    }
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
    // await Future.delayed(Duration(seconds: 2));
    int random = Random().nextInt(4);
    int severity = Random().nextInt(10);
    return [
      Needy(
          '1',
          '1',
          Random().nextInt(5) < 2 ? null : Random().nextDouble() * 100,
          severity,
          getSeverityClass(severity),
          getRandomType(random),
          'details',
          (Random().nextDouble() * 1000).abs(),
          (Random().nextDouble() * 10).abs(),
          Random().nextInt(255).toString(),
          Random().nextBool(),
          Random().nextBool(),
          DateTime.now(),
          getRandomImage(random),
          [],
          Random().nextInt(255).toString(),
          getRandomCharity(random),
          getRandomCharityImage(random))
    ];
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
