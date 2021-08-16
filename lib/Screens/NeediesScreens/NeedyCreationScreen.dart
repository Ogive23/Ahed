import 'dart:io';

import 'package:ahed/ApiCallers/NeedyApiCaller.dart';
import 'package:ahed/Custom%20Widgets/CustomButtonLoading.dart';
import 'package:ahed/Custom%20Widgets/CustomDropdownButton.dart';
import 'package:ahed/Custom%20Widgets/CustomSpacing.dart';
import 'package:ahed/Custom%20Widgets/custom_textfield.dart';
import 'package:ahed/Session/session_manager.dart';
import 'package:ahed/Shared%20Data/app_language.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:ahed/Shared%20Data/common_data.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NeedyCreationScreen extends StatefulWidget {
  @override
  _NeedyCreationScreenState createState() => _NeedyCreationScreenState();
}

class _NeedyCreationScreenState extends State<NeedyCreationScreen> {
  late double w, h;
  late CommonData commonData;
  late AppLanguage appLanguage;
  late AppTheme appTheme;

  final TextEditingController name = new TextEditingController();
  final TextEditingController age = new TextEditingController();
  late int severity = 1;
  String? type;
  final List<String> availableTypes = [
    "إيجاد مسكن مناسب",
    "تحسين مستوي المعيشة",
    "تجهيز لفرحة",
    "سداد الديون",
    "إيجاد علاج"
  ];
  final TextEditingController details = new TextEditingController();
  final TextEditingController need = new TextEditingController();
  final TextEditingController address = new TextEditingController();
  late List<File> selectedImages = [];

  String? nameError;
  String? ageError;
  String? detailsError;
  String? needError;
  String? addressError;

  bool isLoading = false;

  bool fullValidator() {
    print('here');
    bool nameValidation = nameValidator();
    bool ageValidation = ageValidator();
    bool detailsValidation = detailsValidator();
    bool needValidation = needValidator();
    bool addressValidation = addressValidator();
    bool imagesValidation = imagesValidator();
    return nameValidation &&
        ageValidation &&
        detailsValidation &&
        needValidation &&
        addressValidation &&
        imagesValidation;
  }

  bool nameValidator() {
    return onSubmittedName(name.text);
  }

  bool ageValidator() {
    return onSubmittedAge(age.text);
  }

  bool detailsValidator() {
    return onSubmittedDetails(details.text);
  }

  bool needValidator() {
    return onSubmittedNeed(need.text);
  }

  bool addressValidator() {
    return onSubmittedAddress(address.text);
  }

  bool imagesValidator() {
    return selectedImages.isNotEmpty;
  }

  bool onSubmittedName(String value) {
    if (value.length == 0) {
      setState(() {
        nameError = 'الأسم لا يمكن أن يكون فارغاً';
      });
      return false;
    }
    setState(() {
      nameError = null;
    });
    return true;
  }

  bool onSubmittedAge(String value) {
    print(value);
    try {
      int age = int.parse(value);
      if (age < 1) {
        setState(() {
          ageError = "صفر؟";
        });
        return false;
      }
    } catch (e) {
      setState(() {
        ageError = "برجاء إدخال قيمة صحيحة";
      });
      return false;
    }
    setState(() {
      ageError = null;
    });
    return true;
  }

  bool onSubmittedDetails(String value) {
    print('value');
    print(value);
    if (value.length == 0) {
      setState(() {
        detailsError = 'التفاصيل لا يمكن أن تكون فارغة';
      });
      return false;
    }
    setState(() {
      detailsError = null;
    });
    return true;
  }

  bool onSubmittedNeed(String value) {
    print('her e');
    try {
      double need = double.parse(value);
      if (need < 1) {
        setState(() {
          needError = "صفر؟";
        });
        return false;
      }
    } catch (e) {
      setState(() {
        needError = "برجاء إدخال قيمة صحيحة";
      });
      return false;
    }
    setState(() {
      needError = null;
    });
    return true;
  }

  bool onSubmittedAddress(String value) {
    if (value.length == 0) {
      setState(() {
        addressError = 'العنوان لا يمكن أن يكون فارغاً';
      });
      return false;
    }
    setState(() {
      addressError = null;
    });
    return true;
  }

  Future<File?> pickImageFromGallery(ImageSource source) async {
    PickedFile? pickedFile = await new ImagePicker().getImage(source: source);
    if(pickedFile == null)
      return null;
    return File(pickedFile.path);
  }

  changeLoadingState() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    commonData = Provider.of<CommonData>(context);
    appTheme = Provider.of<AppTheme>(context);
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: appTheme.themeData.primaryColor,
      appBar: AppBar(
        backgroundColor: appTheme.themeData.primaryColor,
        elevation: 0.0,
        title: Padding(
          padding: EdgeInsets.only(top: h / 20, bottom: h / 40),
          child: Text(
            'إنشاء طلب إضافة حالة',
            style: appTheme.themeData.primaryTextTheme.headline2,
          ),
        ),
        actions: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: IconButton(
                onPressed: () => commonData.back(),
                icon: Icon(
                  Icons.arrow_back_ios_sharp,
                  color: appTheme.themeData.appBarTheme.iconTheme!.color,
                )),
          )
        ],
      ),
      body: Container(
        // width: w,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: w / 20, right: w / 20, top: h / 100, bottom: h / 200),
                width: w,
                // height: double.infinity
                child: Column(
                  children: [
                    Card(
                      color: appTheme.themeData.cardColor,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: w / 20,
                            right: w / 20,
                            top: h / 100,
                            bottom: h / 200),
                        child: Column(
                          children: [
                            Text(
                              'المعلومات العامة',
                              style:
                                  appTheme.themeData.primaryTextTheme.headline3,
                            ),
                            CustomTextField(
                                controller: name,
                                label: 'أسم الحالة',
                                selectedColor: Color.fromRGBO(38, 92, 126, 1.0),
                                borderColor: Colors.grey,
                                obscureText: false,
                                keyboardType: TextInputType.name,
                                hint: 'أدخل أسم الحالة',
                                error: nameError,
                                width: w,
                                onSubmitted: onSubmittedName,
                                enableFormatters: false,
                                maxLines: 1),
                            CustomSpacing(
                              value: 100,
                            ),
                            CustomTextField(
                                controller: age,
                                label: 'عمر الحالة',
                                selectedColor: Color.fromRGBO(38, 92, 126, 1.0),
                                borderColor: Colors.grey,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                hint: 'أدخل عمر الحالة',
                                error: ageError,
                                width: w,
                                onSubmitted: onSubmittedAge,
                                enableFormatters: true,
                                maxLines: 1),
                            CustomSpacing(
                              value: 100,
                            ),
                            CustomTextField(
                                controller: details,
                                label: 'التفاصيل',
                                selectedColor: Color.fromRGBO(38, 92, 126, 1.0),
                                borderColor: Colors.grey,
                                obscureText: false,
                                keyboardType: TextInputType.text,
                                hint: 'أدخل التفاصيل',
                                error: detailsError,
                                width: w,
                                onSubmitted: onSubmittedDetails,
                                enableFormatters: false,
                                maxLines: 3),
                            CustomSpacing(
                              value: 100,
                            ),
                            CustomTextField(
                                controller: need,
                                label: 'المبلغ المطلوب',
                                selectedColor: Color.fromRGBO(38, 92, 126, 1.0),
                                borderColor: Colors.grey,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                hint: 'أدخل المبلغ المطلوب',
                                error: needError,
                                width: w,
                                onSubmitted: onSubmittedNeed,
                                enableFormatters: true,
                                maxLines: 1),
                            CustomSpacing(
                              value: 100,
                            ),
                            CustomTextField(
                                controller: address,
                                label: 'عنوان الحالة',
                                selectedColor: Color.fromRGBO(38, 92, 126, 1.0),
                                borderColor: Colors.grey,
                                obscureText: false,
                                keyboardType: TextInputType.streetAddress,
                                hint: 'أدخل عنوان الحالة',
                                error: addressError,
                                width: w,
                                onSubmitted: onSubmittedAddress,
                                enableFormatters: false,
                                maxLines: 1),
                            CustomSpacing(
                              value: 100,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: appTheme.themeData.cardColor,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: w / 20,
                            right: w / 20,
                            top: h / 100,
                            bottom: h / 200),
                        child: Column(
                          children: [
                            Text(
                              'المعلومات الفرعية',
                              style:
                                  appTheme.themeData.primaryTextTheme.headline3,
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'نوع الحالة',
                                  style: appTheme
                                      .themeData.primaryTextTheme.headline3,
                                )),
                            CustomSpacing(
                              value: 100,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: w / 20),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: w - w / 10,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.5))),
                                  child: Theme(
                                      data: Theme.of(context).copyWith(
                                        canvasColor:
                                            appTheme.themeData.primaryColor,
                                      ),
                                      child: CustomDropdownButton(
                                          text: 'نوع الحالة',
                                          selectedValue: type,
                                          onChanged: (selectedType) {
                                            setState(() {
                                              type = selectedType;
                                            });
                                          },
                                          items: availableTypes
                                              .map((type) => DropdownMenuItem(
                                                    child: Directionality(
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        child: Container(
                                                          width: w,
                                                          child: Text(
                                                            type,
                                                            textAlign:
                                                                TextAlign.right,
                                                          ),
                                                        )),
                                                    value: type,
                                                  ))
                                              .toList())),
                                ),
                              ),
                            ),
                            CustomSpacing(
                              value: 100,
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'معدل الخطورة',
                                  style: appTheme
                                      .themeData.primaryTextTheme.headline3,
                                )),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Slider(
                                value: severity.toDouble(),
                                min: 1.0,
                                max: 10,
                                onChanged: (double value) {
                                  setState(() {
                                    severity = value.toInt();
                                  });
                                },
                                divisions: 2,
                                label: getLabelBasedOnSeverity(severity),
                                activeColor: getColorBasedOnSeverity(severity),
                                inactiveColor: appTheme.themeData.accentColor
                                    .withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: appTheme.themeData.cardColor,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: w / 20,
                            right: w / 20,
                            top: h / 100,
                            bottom: h / 200),
                        child: Column(
                          children: [
                            Text(
                              'ركن الصور',
                              style:
                                  appTheme.themeData.primaryTextTheme.headline3,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: <Widget>[
                                  TextButton(
                                    onPressed: () async {
                                      File? selectedFile = await pickImageFromGallery(ImageSource.gallery);
                                      if(selectedFile != null)
                                        setState(() {
                                          selectedImages.add(selectedFile);
                                        });
                                    },
                                    child: Text(
                                      'Add Image',
                                      style: appTheme
                                          .themeData.primaryTextTheme.headline5,
                                    ),
                                    style: ButtonStyle(
                                        side: MaterialStateProperty.all<
                                                BorderSide>(
                                            BorderSide(color: Colors.black)),
                                        minimumSize:
                                            MaterialStateProperty.all<Size>(
                                                Size(w / 4, h / 7))),
                                  ),
                                ]+selectedImages.map((image) => Container(
                                  child: Image.file(image,width: w/4,height: h/7,),
                                )).toList(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w / 10),
                child: Text.rich(
                  TextSpan(text: 'برجاء مراجعة ', children: [
                    TextSpan(
                        text: 'القواعد',
                        style: appTheme.themeData.primaryTextTheme.headline4!
                            .apply(
                                decoration: TextDecoration.underline,
                                color: Colors.blue),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () => print('Tap Here onTap')),
                    TextSpan(
                        text:
                            ' الخاصة بإنشاء الحالات حتي لا تتعرض لأي مسائلة قانونية')
                  ]),
                  textAlign: TextAlign.center,
                  style: appTheme.themeData.primaryTextTheme.subtitle1,
                ),
              ),
              isLoading
                  ? CustomButtonLoading()
                  : ElevatedButton(
                      onPressed: () async {
                        if (fullValidator()) {
                          changeLoadingState();
                          NeedyApiCaller needyApiCaller = new NeedyApiCaller();
                          SessionManager sessionManager = new SessionManager();
                          Map<String, dynamic> status =
                              await needyApiCaller.create(
                                  sessionManager.user!.id,
                                  name.text,
                                  int.parse(age.text),
                                  severity,
                                  type!,
                                  details.text,
                                  int.parse(need.text),
                                  address.text,
                                  selectedImages);
                          changeLoadingState();
                          if (status['Err_Flag']) {
                            return CoolAlert.show(
                                context: context,
                                type: CoolAlertType.error,
                                lottieAsset:
                                    'assets/animations/38213-error.json',
                                text: status['Err_Desc'],
                                confirmBtnColor: Color(0xff1c9691),
                                title: '');
                          }
                          commonData.back();
                          return CoolAlert.show(
                              context: context,
                              type: CoolAlertType.success,
                              lottieAsset:
                                  'assets/animations/6951-success.json',
                              text: status['message'],
                              confirmBtnColor: Color(0xff1c9691),
                              title: '');
                        }
                      },
                      child: Text(
                        'إنشاء الطلب',
                        style: appTheme.themeData.primaryTextTheme.bodyText2,
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(38, 92, 126, 1.0))),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  getColorBasedOnSeverity(int severity) {
    print(severity);
    if (severity < 4) return Colors.green;
    if (severity < 7) return Colors.yellow;
    return Colors.red;
  }

  getLabelBasedOnSeverity(int severity) {
    if (severity < 4) return 'يمكنها الإنتظار';
    if (severity < 7) return 'متوسطة';
    return 'حرجة';
  }
}
