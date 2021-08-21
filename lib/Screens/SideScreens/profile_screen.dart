import 'dart:io';
import 'dart:ui';
import 'package:ahed/ApiCallers/UserApiCaller.dart';
import 'package:ahed/Session/session_manager.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:ahed/Shared%20Data/common_data.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ahed/Custom Widgets/CustomImageShower.dart';

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
  final Helper helper = new Helper();
  UserApiCaller userApiCaller = new UserApiCaller();
  List<String> contributions = [
    'My Pets',
    'Pets Acquired',
    'Total Pets Requests',
    'Total Article Read',
    'Total Consultation Created',
    'Total Comments',
    'Total Active Time'
  ];

  bool isEditing = false;

  late TextEditingController address;
  late TextEditingController phoneNumber;
  late TextEditingController bio;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    colorAnimation =
        Tween<Color>(begin: Color.fromRGBO(224, 101, 90, 1.0), end: Colors.blue)
            .animate(animationController);
    address = new TextEditingController(text: sessionManager.user!.address);
    phoneNumber =
        new TextEditingController(text: sessionManager.user!.phoneNumber);
    bio = new TextEditingController(
        text: helper.getAppropriateText(sessionManager.user!.profileBio));
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
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_back_ios_sharp,
                                        color: Colors.black,
                                      ),
                                      onPressed: () => commonData.back(),
                                    isEditing
                                        ? CustomTextField(
                                            controller: bio,
                                            label: "نبذة مختصرة",
                                            selectedColor: Colors.grey,
                                            borderColor: Colors.grey,
                                            obscureText: false,
                                            keyboardType:
                                                TextInputType.streetAddress,
                                            hint: "أدخل نبذة مختصرة عنك",
                                            error: null,
                                            maxLength: 300,
                                            width: w,
                                            enableFormatters: false)
                                        : Text(
                                            '${helper.isNotAvailable(sessionManager.user!.profileBio!) ? 'لا توجد نبذة مختصرة' : sessionManager.user!.profileBio}',
                                            textAlign: TextAlign.center,
                                            style: appTheme.themeData
                                                .primaryTextTheme.bodyText1,
                                          ),
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: h / 50,
                                              horizontal: w / 40),
                                          child: Text(
                                            'المعلومات الشخصية',
                                            style: appTheme.themeData
                                                .primaryTextTheme.headline3,
                                          ),
                                        )),
                                    CustomSpacing(
                                      value: 100,
                                    ),
                                    isEditing
                                        ? CustomTextField(
                                            controller: address,
                                            label: "العنوان",
                                            selectedColor: Colors.grey,
                                            borderColor: Colors.grey,
                                            obscureText: false,
                                            keyboardType:
                                                TextInputType.streetAddress,
                                            hint: "أدخل عنوانك",
                                            error: null,
                                            width: w,
                                            enableFormatters: false)
                                        : CustomRowText(
                                            firstText: "العنوان",
                                            secondText:
                                                sessionManager.user!.address),
                                    CustomSpacing(
                                      value: 100,
                                    ),
                                    isEditing
                                        ? CustomTextField(
                                            controller: phoneNumber,
                                            label: "رقم الهاتف",
                                            selectedColor: Colors.grey,
                                            borderColor: Colors.grey,
                                            obscureText: false,
                                            keyboardType:
                                                TextInputType.streetAddress,
                                            hint: "أدخل رقم هاتفك",
                                            error: null,
                                            width: w,
                                            enableFormatters: false)
                                        : CustomRowText(
                                            firstText: "رقم الهاتف",
                                            secondText: sessionManager
                                                .user!.phoneNumber),
                                  ],
                                ),
                              ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: h / 5),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: isEditing
                                      ? IconButton(
                                          icon: Icon(
                                            Icons.done,
                                            color: Colors.black,
                                          ),
                                          onPressed: () async{
                                            Map<String,dynamic> status = await userApiCaller.changeUserInformation(
                                              sessionManager.user!.id,
                                              bio.text,
                                              address.text,
                                              phoneNumber.text
                                            );
                                            setState(() {
                                              isEditing = !isEditing;
                                            });
                                            if (!status['Err_Flag']) {
                                              sessionManager.changeUserInfo(
                                                bio.text,
                                                address.text,
                                                phoneNumber.text
                                              );
                                              return CoolAlert.show(
                                                  context: context,
                                                  type: CoolAlertType.success,
                                                  lottieAsset: 'assets/animations/6951-success.json',
                                                  text: status['message'],
                                                  confirmBtnColor: Color(0xff1c9691),
                                                  title: '');
                                            } else {
                                              return CoolAlert.show(
                                                  context: context,
                                                  type: CoolAlertType.error,
                                                  lottieAsset: 'assets/animations/38213-error.json',
                                                  text: status['Err_Desc'],
                                                  confirmBtnColor: Color(0xff1c9691),
                                                  title: '');
                                            }
                                          },
                                        )
                                      : IconButton(
                                          icon: Icon(
                                            Icons.build,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              isEditing = !isEditing;
                                            });
                                            print(isEditing);
                                          },
                                        ),
                                ),
  }

  Future<File?> pickImageFromGallery(ImageSource source) async {
    PickedFile? pickedFile = await new ImagePicker().getImage(source: source);
    return File(pickedFile!.path);
  }

  Future<void> uploadImage(ImageSource source) async {
    File? image = await pickImageFromGallery(source);
    if (image != null) {
      UserApiCaller userApiCaller = new UserApiCaller();
      Map<String, dynamic> status = await userApiCaller.changeProfilePicture(
          sessionManager.user!.id, image);
      if (!status['Err_Flag']) {
        Navigator.pop(context);
        imageCache!.clear();
        imageCache!.clearLiveImages();
        setState(() {});
        return CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            lottieAsset: 'assets/animations/6951-success.json',
            text: status['message'],
            confirmBtnColor: Color(0xff1c9691),
            title: '');
      }else {
        return CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            lottieAsset: 'assets/animations/38213-error.json',
            text: status['Err_Desc'],
            confirmBtnColor: Color(0xff1c9691),
            title: '');
      }
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
