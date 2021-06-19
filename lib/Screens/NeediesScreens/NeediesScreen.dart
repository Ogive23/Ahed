import 'dart:math';
import 'package:ahed/ApiCallers/NeedyApiCaller.dart';
import 'package:ahed/Custom%20Widgets/CustomLoading.dart';
import 'package:ahed/Custom%20Widgets/CustomNeedyContainer.dart';
import 'package:ahed/Custom%20Widgets/CustomSpacing.dart';
import 'package:ahed/Custom%20Widgets/LoadingNeedyContainer.dart';
import 'package:ahed/Models/Needy.dart';
import 'package:ahed/Models/NeedyMedia.dart';
import 'package:ahed/Session/session_manager.dart';
import 'package:ahed/Shared%20Data/app_language.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:ahed/Shared%20Data/common_data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NeediesScreen extends StatefulWidget {
  final String type;
  NeediesScreen({@required this.type});
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
  SessionManager sessionManager = new SessionManager();
  TabController tabController;
  @override
  initState() {
    super.initState();
    initNeedies();
  }

  initNeedies() async {
    List<Needy> addedNeedies;
    if(widget.type == "Bookmarked")
        addedNeedies = await getGeneratedNeedies(sessionManager.getBookmarkedNeedies());
    else
      addedNeedies = await getGeneratedNeedies();
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
      return Center(
        child: Text(
          'لا توجد حالات متاحة',
          style: appTheme.themeData.primaryTextTheme.subtitle1,
        ),
      );
    return Center(
        child: CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 0.7,
              height: h / 1.6,
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

  getRandomType(int randomNumber) {
    switch (randomNumber) {
      case 0:
        return 'إيجاد مسكن';
      case 1:
        return 'تحسين مستوي المعيشة';
      case 2:
        return 'تجهيز عروس';
      case 3:
        return 'ديون';
      case 4:
        return 'علاج';
    }
  }

  String getRandomImage(int randomNumber) {
    print(randomNumber);
    switch (randomNumber) {
      case 0:
        return 'assets/images/2018_12_05_4268-Edit.jpg';
      case 1:
        return 'assets/images/319028.jpg';
      case 2:
        return 'assets/images/images.jpg';
      case 3:
        return 'assets/images/dept.jpg';
      case 4:
        return 'assets/images/child-hospital-002.jpg';
    }
  }

  String getRandomCharity(int randomNumber) {
    print(randomNumber);
    switch (randomNumber) {
      case 0:
        return 'رسالة';
      case 1:
        return 'جمعية البر';
      case 2:
        return 'الجليلة';
      case 3:
        return 'خلف أحمد الهبتور';
      case 4:
        return 'مجدي يعقوب';
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

  Future<List<Needy>> getGeneratedNeedies([List<String> bookmarkedNeediesIDs]) async {
    int random = Random().nextInt(4);
    int severity = Random().nextInt(10);
    return [
      Needy(
          '1',
          '1',
          Random().nextInt(5) < 2 ? null : Random().nextDouble() * 100,
          widget.type == "Urgent" ? 7 : 1,
          getSeverityClass(severity),
          getRandomType(random),
          'التفاصيل',
          (Random().nextDouble() * 1000).abs(),
          (Random().nextDouble() * 10).abs(),
          Random().nextInt(255).toString(),
          Random().nextBool(),
          Random().nextBool(),
          DateTime.now(),
          [NeedyMedia('id', getRandomImage(random))],
          [],
          Random().nextInt(255).toString(),
          getRandomCharity(random),
          getRandomCharityImage(random)),
    ];
    //ToDo: Remove Comments
    NeedyApiCaller needyApiCaller = new NeedyApiCaller();
    Map<String, dynamic> status = await needyApiCaller.getAllUrgent();
    print(status);
    if (!status['Err_Flag']) return status['Values'];
    //ToDo: Handle Error
    print(status['Err_Flag']);
  }

  @override
  Widget build(BuildContext context) {
    commonData = Provider.of<CommonData>(context);
    appTheme = Provider.of<AppTheme>(context);
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSpacing(),
        getNeediesBody(context),
      ],
    );
  }

  String getSeverityClass(int severity) {
    if (severity > 0 && severity < 4) return 'يمكنها الإنتظار';
    if (severity > 4 && severity < 7) return 'متوسطة';
    return 'حرجة';
  }
}
