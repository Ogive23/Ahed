import 'package:ahed/ApiCallers/NeedyApiCaller.dart';
import 'package:ahed/Custom%20Widgets/CustomLoading.dart';
import 'package:ahed/Custom%20Widgets/CustomNeedyContainer.dart';
import 'package:ahed/Custom%20Widgets/CustomSpacing.dart';
import 'package:ahed/Custom%20Widgets/LoadingNeedyContainer.dart';
import 'package:ahed/Models/Needy.dart';
import 'package:ahed/Session/session_manager.dart';
import 'package:ahed/Shared%20Data/app_language.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NeediesScreen extends StatefulWidget {
  final String type;
  NeediesScreen({required this.type});
  @override
  _NeediesScreenState createState() => _NeediesScreenState();
}

class _NeediesScreenState extends State<NeediesScreen> {
  static late double w, h;
  static late AppTheme appTheme;
  static late AppLanguage appLanguage;
  List<Needy>? needies;
  int current = 0;
  SessionManager sessionManager = SessionManager();
  int currentPage = 1;
  late int total;

  @override
  initState() {
    super.initState();
    initNeedies();
  }

  initNeedies() async {
    List<Needy> addedNeedies;

    //ToDo: Future V2
    // if (widget.type == "Bookmarked" && sessionManager.hasAnyBookmarked())
    //   addedNeedies = await getGeneratedNeedies(
    //       "Bookmarked", sessionManager.getBookmarkedNeedies());
    // else
    addedNeedies = await getGeneratedNeedies(widget.type);
    setState(() {
      needies = [];
      needies!.addAll(addedNeedies);
    });
  }

  Widget getNeediesBody(context) {
    if (needies == null) {
      return Container(alignment: Alignment.center, child: CustomLoading());
    }
    if (needies!.isEmpty) {
      return Center(
        child: Text(
          'لا توجد حالات متاحة',
          style: appTheme.themeData.primaryTextTheme.subtitle1,
        ),
      );
    }
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
                if (current == needies!.length && current < total) {
                  currentPage++;
                  List<Needy> addedNeedies =
                      await getGeneratedNeedies(widget.type);
                  setState(() {
                    needies!.addAll(addedNeedies);
                  });
                }
              },
            ),
            items: <Widget>[] +
                needies!
                    .map((needy) => CustomNeedyContainer(needy: needy))
                    .toList() +
                getLoadingContainerIfExists()));
  }

  List<Widget> getLoadingContainerIfExists() {
    //ToDo: Future V2
    // if (widget.type == "Bookmarked") return <Widget>[];
    return needies!.isEmpty || needies!.length < total
        ? <Widget>[const LoadingNeedyContainer()]
        : <Widget>[];
  }

  Future<List<Needy>> getGeneratedNeedies(String type,
      [List<String>? bookmarkedNeediesIDs]) async {
    NeedyApiCaller needyApiCaller = NeedyApiCaller();
    late Map<String, dynamic> status;
    if (type == 'Urgent') {
      status =
          await needyApiCaller.getAllUrgent(appLanguage.language!, currentPage);
    }
    if (type == 'Not Urgent') {
      status = await needyApiCaller.getAll(appLanguage.language!, currentPage);
    }

    print(status);
    //ToDo: Future V2
    // if (type == 'Bookmarked')
    //   status = await needyApiCaller.getAllBookmarked(bookmarkedNeediesIDs);

    if (!status['Err_Flag']) {
      setState(() {
        // this.lastPage = status['lastPage'];
        total = status['total'];
      });
      return status['Values'];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    appTheme = Provider.of<AppTheme>(context);
    appLanguage = Provider.of<AppLanguage>(context);
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.type == 'Urgent' ? 'الحالات الحرجة' : 'الحالات',
            style: appTheme.themeData.primaryTextTheme.headline3),
        const CustomSpacing(
          value: 100,
        ),
        getNeediesBody(context),
      ],
    );
  }
}
