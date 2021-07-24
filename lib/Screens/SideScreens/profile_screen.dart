import 'dart:io';
import 'dart:ui';
import 'package:ahed/Session/session_manager.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:ahed/Shared%20Data/common_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  static late double w, h;
  final SessionManager sessionManager = new SessionManager();
  static late AppTheme appTheme;
  static late CommonData commonData;
  static late AnimationController animationController;
  static late Animation<Color> colorAnimation;
  final GlobalKey toolTipKey = GlobalKey();
  static late File image;
  List<String> contributions = [
    'My Pets',
    'Pets Acquired',
    'Total Pets Requests',
    'Total Article Read',
    'Total Consultation Created',
    'Total Comments',
    'Total Active Time'
  ];

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    colorAnimation =
        Tween<Color>(begin: Color.fromRGBO(224, 101, 90, 1.0), end: Colors.blue)
            .animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    appTheme = Provider.of<AppTheme>(context);
    commonData = Provider.of<CommonData>(context);
    return Material(
        child: SafeArea(
            child: Container(
                height: double.infinity,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: sessionManager.user!.profileImage != 'N/A'
                          ? DecorationImage(
                              image: NetworkImage(
                                sessionManager.user!.profileImage!,
                              ),
                              colorFilter: ColorFilter.mode(
                                  appTheme.themeData.primaryColor,
                                  BlendMode.softLight),
                              fit: BoxFit.cover,
                            )
                          : DecorationImage(
                              image: AssetImage(
                                'assets/images/user.png',
                              ),
                              colorFilter: ColorFilter.mode(
                                  appTheme.themeData.primaryColor,
                                  BlendMode.softLight),
                              fit: BoxFit.cover,
                            )),
                  child: ClipRRect(
                      child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.arrow_back_ios_sharp,
                                          color: Colors.black,
                                        ),
                                        onPressed: () => commonData.back(),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5),
                                        padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              10,
                                        ),
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.5)),
                                        child: Column(
                                          children: [
                                            Text(
                                              sessionManager.user!.name,
                                              style: appTheme
                                                  .nonStaticGetTextStyle(
                                                      1.0,
                                                      appTheme
                                                          .themeData
                                                          .primaryTextTheme
                                                          .bodyText1!
                                                          .color,
                                                      appTheme.getTextTheme(
                                                          context),
                                                      FontWeight.w500,
                                                      1.0,
                                                      TextDecoration.none,
                                                      "OpenSans",
                                                      [
                                                    Shadow(
                                                        // bottomLeft
                                                        offset:
                                                            Offset(-1.0, -1.0),
                                                        color: Colors.white),
                                                    Shadow(
                                                        // bottomRight
                                                        offset:
                                                            Offset(1.0, -1.0),
                                                        color: Colors.white),
                                                    Shadow(
                                                        // topRight
                                                        offset:
                                                            Offset(1.0, 1.0),
                                                        color: Colors.white),
                                                    Shadow(
                                                        // topLeft
                                                        offset:
                                                            Offset(-1.0, 1.0),
                                                        color: Colors.white),
                                                  ]),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  100,
                                            ),
                                            Text('London, UK',
                                                style: appTheme
                                                    .nonStaticGetTextStyle(
                                                        1.0,
                                                        appTheme
                                                            .themeData
                                                            .primaryTextTheme
                                                            .bodyText1!
                                                            .color,
                                                        appTheme
                                                            .getSemiBodyTextTheme(
                                                                context),
                                                        FontWeight.w500,
                                                        1.0,
                                                        TextDecoration.none,
                                                        "OpenSans")),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  50,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      10,
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      10),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text.rich(
                                                        TextSpan(
                                                            text: 'Profile',
                                                            children: [
                                                              TextSpan(
                                                                  text: ' 70%',
                                                                  style: appTheme.nonStaticGetTextStyle(
                                                                      1.0,
                                                                      appTheme
                                                                          .themeData
                                                                          .primaryTextTheme
                                                                          .bodyText1!
                                                                          .color,
                                                                      appTheme.getSemiBodyTextTheme(
                                                                          context),
                                                                      FontWeight
                                                                          .w500,
                                                                      1.0,
                                                                      TextDecoration
                                                                          .none,
                                                                      "OpenSans"))
                                                            ],
                                                            style: appTheme.nonStaticGetTextStyle(
                                                                1.0,
                                                                Colors.black
                                                                    .withOpacity(
                                                                        0.5),
                                                                appTheme
                                                                    .getSemiBodyTextTheme(
                                                                        context),
                                                                FontWeight.w500,
                                                                1.0,
                                                                TextDecoration
                                                                    .none,
                                                                "OpenSans")),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            final dynamic
                                                                tooltip =
                                                                toolTipKey
                                                                    .currentState;
                                                            tooltip
                                                                .ensureTooltipVisible();
                                                          },
                                                          child: Tooltip(
                                                            key: toolTipKey,
                                                            showDuration:
                                                                Duration(
                                                                    seconds: 5),
                                                            message:
                                                                'You Have to\nYou Have to',
                                                            child: Icon(
                                                              Icons
                                                                  .info_outline,
                                                              size: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  20,
                                                              color: appTheme
                                                                  .themeData
                                                                  .iconTheme
                                                                  .color,
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            100,
                                                  ),
                                                  LinearProgressIndicator(
                                                    value: 0.7,
                                                    backgroundColor:
                                                        Colors.black,
                                                    valueColor: colorAnimation,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  80,
                                            ),
                                            Divider(),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  80,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      10,
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Current Title',
                                                      style: appTheme
                                                          .nonStaticGetTextStyle(
                                                              1.0,
                                                              Colors.black,
                                                              appTheme
                                                                  .getSemiBodyTextTheme(
                                                                      context),
                                                              FontWeight.w500,
                                                              1.0,
                                                              TextDecoration
                                                                  .none,
                                                              "OpenSans")),
                                                  Text('Something',
                                                      style: appTheme
                                                          .nonStaticGetTextStyle(
                                                              1.0,
                                                              appTheme
                                                                  .themeData
                                                                  .primaryTextTheme
                                                                  .bodyText1!
                                                                  .color,
                                                              appTheme
                                                                  .getTextTheme(
                                                                      context),
                                                              FontWeight.w500,
                                                              1.0,
                                                              TextDecoration
                                                                  .none,
                                                              "OpenSans"))
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  80,
                                            ),
                                            Divider(),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                10),
                                        decoration: BoxDecoration(boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.7),
                                              blurRadius: 60,
                                              offset: Offset(0, 4))
                                        ]),
                                        child: GestureDetector(
                                          child: CircleAvatar(
                                            radius: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                10,
                                            backgroundColor: Colors.transparent,
                                            child: ClipOval(
                                              child: sessionManager
                                                          .user!.profileImage !=
                                                      'N/A'
                                                  ? Image.network(
                                                      sessionManager
                                                          .user!.profileImage!,
                                                      fit: BoxFit.fill,
                                                      width: w / 5,
                                                      height: h / 10,
                                                    )
                                                  : Image.asset(
                                                      'assets/images/user.png',
                                                      fit: BoxFit.cover,
                                                      width: w / 5,
                                                      height: h / 10,
                                                    ),
                                            ),
                                          ),
                                          onTap: () {
                                            onImagePressed(context);
                                          },
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                Icons.auto_fix_high,
                                                color: appTheme
                                                    .themeData.primaryColor,
                                              ),
                                              onPressed: () {},
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.build,
                                                color: appTheme
                                                    .themeData.primaryColor,
                                              ),
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ))),
                ))));
  }

  Color getColor(int number) {
    if (number < 5) return Colors.red;
    if (number < 10) return Colors.yellow;
    return Colors.green;
  }

  String getText(int index, int number) {
    switch (index) {
      case 6:
        return number.toString() + ' MIN';
      default:
        return number.toString();
    }
  }

  Future<File> pickImageFromGallery(ImageSource source) async {
    PickedFile? pickedFile = await new ImagePicker().getImage(source: source);
    return File(pickedFile!.path);
  }

  uploadImage(ImageSource source) async {
    image = await pickImageFromGallery(source);
    // UserApi apiCaller = new UserApi();
    // String status = await apiCaller.updateProfilePicture(
    //     userData: {'image': image, 'userId': sessionManager.getUser().id});
    // if ('done' == status) {
    //   User user = await apiCaller
    //       .getById(userData: {'userId': sessionManager.getUser().id});
    //   sessionManager.logout();
    //   sessionManager.createSession(user);
    //   sessionManager.loadSession();
    //   setState(() {});
    // } else {
    //   Toast.show('Error!', context);
    // }
  }

  void onImagePressed(context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width / 2,
                buttonColor: Colors.transparent,
                child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(0.0)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomImageShower(
                                url: sessionManager.user!.profileImage)));
                  },
                  child: Text('Show profile picture'),
                ),
              ),
              Divider(
                height: 1,
                color: Colors.black.withOpacity(0.5),
                indent: 10,
                endIndent: 10,
              ),
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width / 2,
                buttonColor: Colors.transparent,
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(0.0),
                  ),
                  onPressed: () async {
                    await uploadImage(ImageSource.gallery);
                  },
                  child: Text('Change profile picture'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomImageShower extends StatelessWidget {
  final url;
  SessionManager sessionManager = new SessionManager();
  CustomImageShower({this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: sessionManager.user!.profileImage != 'N/A'
            ? Image.network(this.url)
            : Image.asset(
                'assets/images/user.png',
              ),
      ),
    );
  }
}
