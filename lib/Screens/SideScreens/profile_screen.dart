// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:ui';
import 'package:ahed/ApiCallers/UserApiCaller.dart';
import 'package:ahed/Custom%20Widgets/CustomButtonLoading.dart';
import 'package:ahed/Custom%20Widgets/CustomRowText.dart';
import 'package:ahed/Custom%20Widgets/CustomSpacing.dart';
import 'package:ahed/Custom%20Widgets/custom_textfield.dart';
import 'package:ahed/Helpers/Helper.dart';
import 'package:ahed/Session/session_manager.dart';
import 'package:ahed/Shared%20Data/app_language.dart';
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

class _ProfileScreenState extends State<ProfileScreen> {
  static late double w, h;
  final SessionManager sessionManager = SessionManager();
  static late AppTheme appTheme;
  static late AppLanguage appLanguage;
  static late CommonData commonData;
  final Helper helper = Helper();
  UserApiCaller userApiCaller = UserApiCaller();
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

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    address = TextEditingController(text: sessionManager.user!.address);
    phoneNumber = TextEditingController(text: sessionManager.user!.phoneNumber);
    bio = TextEditingController(
        text: helper.getAppropriateText(sessionManager.user!.profileBio));
  }

  changeLoadingState() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    appTheme = Provider.of<AppTheme>(context);
    appLanguage = Provider.of<AppLanguage>(context);
    commonData = Provider.of<CommonData>(context);
    return SafeArea(
      child: SizedBox(
          height: h,
          child: SingleChildScrollView(
            child: Container(
              width: w,
              decoration: BoxDecoration(
                  image: sessionManager.user!.profileCover != null
                      ? DecorationImage(
                          image: NetworkImage(
                            sessionManager.user!.profileCover!,
                          ),
                          colorFilter: ColorFilter.mode(
                              appTheme.themeData.primaryColor,
                              BlendMode.softLight),
                          fit: BoxFit.cover,
                        )
                      : DecorationImage(
                          image: const AssetImage(
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
                      child: SizedBox(
                        width: w,
                        height: h,
                        child: Column(
                          // alignment: Alignment.topCenter,
                          children: [
                            Container(
                              color: appTheme.themeData.primaryTextTheme
                                  .headlineSmall!.color!
                                  .withOpacity(0.5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'الملف الشخصي',
                                    style: appTheme
                                        .themeData.primaryTextTheme.headline2,
                                  ),
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: IconButton(
                                        onPressed: () => commonData.back(),
                                        icon: Icon(
                                          Icons.arrow_back_ios_sharp,
                                          color: appTheme.themeData.appBarTheme
                                              .iconTheme!.color,
                                        )),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    child: const Text('تغيير الغلاف'),
                                    onPressed: () {
                                      onImagePressed(context, 'Cover');
                                    },
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: isEditing
                                        ? isLoading
                                            ? const CustomButtonLoading()
                                            : IconButton(
                                                icon: const Icon(
                                                  Icons.done,
                                                  color: Colors.green,
                                                ),
                                                onPressed: () async {
                                                  changeLoadingState();
                                                  Map<String, dynamic> status =
                                                      await userApiCaller
                                                          .changeUserInformation(
                                                              appLanguage
                                                                  .language!,
                                                              sessionManager
                                                                  .user!.id,
                                                              bio.text,
                                                              address.text,
                                                              phoneNumber.text);
                                                  isEditing = !isEditing;
                                                  changeLoadingState();
                                                  if (!status['Err_Flag']) {
                                                    sessionManager
                                                        .changeUserInfo(
                                                            bio.text,
                                                            address.text,
                                                            phoneNumber.text);
                                                    return CoolAlert.show(
                                                        context: context,
                                                        type: CoolAlertType
                                                            .success,
                                                        lottieAsset:
                                                            'assets/animations/6951-success.json',
                                                        text: status['message'],
                                                        confirmBtnColor:
                                                            const Color(
                                                                0xff1c9691),
                                                        title: '');
                                                  } else {
                                                    return CoolAlert.show(
                                                        context: context,
                                                        type:
                                                            CoolAlertType.error,
                                                        lottieAsset:
                                                            'assets/animations/38213-error.json',
                                                        text:
                                                            status['Err_Desc'],
                                                        confirmBtnColor:
                                                            const Color(
                                                                0xff1c9691),
                                                        title: '');
                                                  }
                                                },
                                              )
                                        : IconButton(
                                            icon: const Icon(
                                              Icons.build,
                                              color: Colors.blue,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                isEditing = !isEditing;
                                              });
                                              print(isEditing);
                                            },
                                          ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 60,
                                    offset: const Offset(0, 4))
                              ]),
                              child: GestureDetector(
                                child: CircleAvatar(
                                  radius: h / 10,
                                  backgroundColor: Colors.transparent,
                                  child: ClipOval(
                                    child: sessionManager.user!.profileImage !=
                                            null
                                        ? Image.network(
                                            sessionManager.user!.profileImage!,
                                            fit: BoxFit.cover,
                                            width: w / 5,
                                            height: h / 10,
                                            errorBuilder: (context, error,
                                                    stackTrace) =>
                                                Image.asset(
                                                    'assets/images/user.png'),
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
                                  onImagePressed(context, 'Profile');
                                },
                              ),
                            ),
                            Container(
                              width: w,
                              // margin: EdgeInsets.only(top: h / 5),
                              padding: EdgeInsets.symmetric(
                                vertical: h / 50,
                              ),
                              decoration: BoxDecoration(
                                  color: appTheme.themeData.primaryTextTheme
                                      .headlineSmall!.color!
                                      .withOpacity(0.8)),
                              child: Column(
                                children: [
                                  Text(
                                    sessionManager.user!.name,
                                    style: appTheme.nonStaticGetTextStyle(
                                      1.0,
                                      appTheme.themeData.primaryTextTheme
                                          .bodyText1!.color,
                                      appTheme.largeTextSize(context),
                                      FontWeight.w500,
                                      1.0,
                                      TextDecoration.none,
                                      'OpenSans',
                                    ),
                                  ),
                                  const CustomSpacing(
                                    value: 100,
                                  ),
                                  isEditing
                                      ? CustomTextField(
                                          controller: bio,
                                          label: 'نبذة مختصرة',
                                          selectedColor: Colors.grey,
                                          borderColor: Colors.grey,
                                          obscureText: false,
                                          keyboardType:
                                              TextInputType.streetAddress,
                                          hint: 'أدخل نبذة مختصرة عنك',
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
                                  const CustomSpacing(
                                    value: 100,
                                  ),
                                  isEditing
                                      ? CustomTextField(
                                          controller: address,
                                          label: 'العنوان',
                                          selectedColor: Colors.grey,
                                          borderColor: Colors.grey,
                                          obscureText: false,
                                          keyboardType:
                                              TextInputType.streetAddress,
                                          hint: 'أدخل عنوانك',
                                          error: null,
                                          width: w,
                                          enableFormatters: false)
                                      : CustomRowText(
                                          firstText: 'العنوان',
                                          secondText:
                                              sessionManager.user!.address ??
                                                  ''),
                                  const CustomSpacing(
                                    value: 100,
                                  ),
                                  isEditing
                                      ? CustomTextField(
                                          controller: phoneNumber,
                                          label: 'رقم الهاتف',
                                          selectedColor: Colors.grey,
                                          borderColor: Colors.grey,
                                          obscureText: false,
                                          keyboardType:
                                              TextInputType.streetAddress,
                                          hint: 'أدخل رقم هاتفك',
                                          error: null,
                                          width: w,
                                          enableFormatters: false)
                                      : CustomRowText(
                                          firstText: 'رقم الهاتف',
                                          secondText:
                                              sessionManager.user!.phoneNumber),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ))),
            ),
          )),
    );
  }

  Future<File?> pickImageFromGallery(ImageSource source) async {
    PickedFile? pickedFile = await ImagePicker().getImage(source: source);
    return File(pickedFile!.path);
  }

  Future<void> uploadImage(ImageSource source, String relatedImage) async {
    File? image = await pickImageFromGallery(source);
    if (image != null) {
      Map<String, dynamic> status;
      if (relatedImage == 'Profile') {
        status = await userApiCaller.changeProfilePicture(
            appLanguage.language!, sessionManager.user!.id, image);
      } else {
        status = await userApiCaller.changeCoverPicture(
            appLanguage.language!, sessionManager.user!.id, image);
      }
      if (!status['Err_Flag']) {
        imageCache.clear();
        imageCache.clearLiveImages();
        setState(() {});
        return CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            lottieAsset: 'assets/animations/6951-success.json',
            text: status['message'],
            confirmBtnColor: const Color(0xff1c9691),
            title: '');
      } else {
        return CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            lottieAsset: 'assets/animations/38213-error.json',
            text: status['Err_Desc'],
            confirmBtnColor: const Color(0xff1c9691),
            title: '');
      }
    }
  }

  void onImagePressed(context, relatedImage) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: appTheme.themeData.primaryColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(0.0),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent)),
                onPressed: relatedImage == 'Profile' &&
                            sessionManager.user!.profileImage == null ||
                        relatedImage == 'Cover' &&
                            sessionManager.user!.profileCover == null
                    ? null
                    : () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomImageShower(
                                    url: relatedImage == 'Profile'
                                        ? sessionManager.user!.profileImage
                                        : sessionManager.user!.profileCover)));
                      },
                child: Text(
                  relatedImage == 'Profile'
                      ? 'Show Profile Picture'
                      : 'Show Cover Picture',
                  style: appTheme.themeData.primaryTextTheme.headlineSmall,
                ),
              ),
              Divider(
                height: 1,
                color: Colors.black.withOpacity(0.5),
                indent: 10,
                endIndent: 10,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(0.0),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent)),
                onPressed: () async {
                  await uploadImage(ImageSource.gallery, relatedImage);
                },
                child: Text(
                  relatedImage == 'Profile'
                      ? 'Change Profile Picture'
                      : 'Change Cover Picture',
                  style: appTheme.themeData.primaryTextTheme.headlineSmall,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
