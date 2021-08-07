import 'package:ahed/ApiCallers/TransactionApiCaller.dart';
import 'package:ahed/Custom%20Widgets/CustomSpacing.dart';
import 'package:ahed/Custom%20Widgets/custom_textfield.dart';
import 'package:ahed/Session/session_manager.dart';
import 'package:ahed/Shared%20Data/app_language.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:ahed/Shared%20Data/common_data.dart';
import 'package:ahed/Shared%20Data/NeedyData.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart' as intl;
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class OfflineTransactionCreationScreen extends StatefulWidget {
  @override
  _OfflineTransactionCreationScreenState createState() =>
      _OfflineTransactionCreationScreenState();
}

class _OfflineTransactionCreationScreenState
    extends State<OfflineTransactionCreationScreen> {
  late double w, h;
  late CommonData commonData;
  late NeedyData needyData;
  late AppLanguage appLanguage;
  late AppTheme appTheme;
  final TextEditingController amount = new TextEditingController();
  late String preferredSection;
  final TextEditingController address = new TextEditingController();
  final TextEditingController mobileNumber = new TextEditingController();
  String? amountError;
  String? addressError;
  String? mobileNumberError;
  String? dateError;
  static DateTime startCollectDate = DateTime.now();
  static DateTime endCollectDate = DateTime.now();
  // DateTime from = new DateTime.now();
  // DateTime to = new DateTime.now();
  static bool assignPermanently = false;

  bool fullValidator() {
    return amountValidator() &&
        addressValidator() &&
        mobileNumberValidator() &&
        datesValidator();
  }

  bool datesValidator() {
    return onSubmittedSelectedDates(startCollectDate, endCollectDate);
  }

  bool amountValidator() {
    return onSubmittedAmount(amount.text);
  }

  bool addressValidator() {
    return onSubmittedAddress(address.text);
  }

  bool mobileNumberValidator() {
    return onSubmittedMobileNumber(mobileNumber.text);
  }

  bool onSubmittedSelectedDates(
      DateTime startCollectDate, DateTime endCollectDate) {
    if (startCollectDate.isAfter(endCollectDate)) {
      setState(() {
        dateError = "خطأ في إختيار الفترة";
      });
      return false;
    }
    setState(() {
      dateError = '';
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

  bool onSubmittedAmount(String value) {
    try {
      double amount = double.parse(value);
      if (amount < 1) {
        setState(() {
          amountError = "صفر؟";
        });
        return false;
      }
    } catch (e) {
      setState(() {
        amountError = "برجاء إدخال قيمة صحيحة";
      });
      return false;
    }
    setState(() {
      amountError = null;
    });
    return true;
  }

  bool onSubmittedMobileNumber(String value) {
    if (value.length == 0) {
      setState(() {
        mobileNumberError = 'رقم الهاتف لا يمكن أن يكون فارغاً';
      });
      return false;
    }
    setState(() {
      mobileNumberError = null;
    });
    return true;
  }

  Future<void> selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: startCollectDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != startCollectDate)
      setState(() {
        startCollectDate = picked;
      });
  }

  Future<void> selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: endCollectDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != endCollectDate)
      setState(() {
        endCollectDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    commonData = Provider.of<CommonData>(context);
    needyData = Provider.of<NeedyData>(context);
    appTheme = Provider.of<AppTheme>(context);
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Padding(
          padding: EdgeInsets.only(top: h / 20, bottom: h / 40),
          child: Text(
            'تبرع',
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
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: w / 10, right: w / 10, top: h / 100, bottom: h / 200),
                width: w,
                // height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('أسم الحالة: ',
                            style:
                                appTheme.themeData.primaryTextTheme.headline4),
                        Text('${needyData.selectedNeedy!.name}',
                            style:
                                appTheme.themeData.primaryTextTheme.headline4),
                      ],
                    ),
                    CustomSpacing(),
                    Row(
                      children: [
                        Text('نوع الحالة: ',
                            style:
                                appTheme.themeData.primaryTextTheme.headline4),
                        Text('${needyData.selectedNeedy!.type}',
                            style:
                                appTheme.themeData.primaryTextTheme.headline4),
                      ],
                    ),
                    CustomSpacing(),
                    Row(
                      children: [
                        Text('التفاصيل: ',
                            style:
                                appTheme.themeData.primaryTextTheme.headline4),
                        Text('${needyData.selectedNeedy!.details}',
                            style:
                                appTheme.themeData.primaryTextTheme.headline4),
                      ],
                    ),
                    CustomSpacing(),
                    Row(
                      children: [
                        Text('مسار النجاح: ',
                            style:
                                appTheme.themeData.primaryTextTheme.headline4),
                        LinearPercentIndicator(
                          width: w / 2,
                          alignment: MainAxisAlignment.center,
                          animation: true,
                          padding: EdgeInsets.symmetric(vertical: h / 100),
                          animationDuration: 1000,
                          lineHeight: h / 25,
                          linearGradient: LinearGradient(
                              colors: [Colors.green, Colors.greenAccent]),
                          percent: needyData.selectedNeedy!.collected! /
                              needyData.selectedNeedy!.need!,
                          center: Text(
                            (needyData.selectedNeedy!.need! -
                                        needyData.selectedNeedy!.collected!)
                                    .toStringAsFixed(0) +
                                ' جنيه متبقي',
                            style:
                                appTheme.themeData.primaryTextTheme.bodyText2,
                          ),
                          linearStrokeCap: LinearStrokeCap.butt,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: w / 10, vertical: h / 200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: h / 100),
                        child: Text('بيانات الدفع',
                            style:
                                appTheme.themeData.primaryTextTheme.headline3)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextField(
                            controller: amount,
                            label: 'المبلغ',
                            selectedIcon: FontAwesomeIcons.moneyBill,
                            selectedColor: Color.fromRGBO(38, 92, 126, 1.0),
                            borderColor: Colors.grey,
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            hint: 'برجاء إدخال المبلغ المراد التبرع به',
                            error: amountError,
                            width: w / 2,
                            onChanged: null,
                            onSubmitted: onSubmittedAmount,
                            rightInfo: amountValidator(),
                            enableFormatters: true,
                            maxLines: 1),
                        SizedBox(
                          width: w / 100,
                        ),
                        Text(
                          'جنيه مصري',
                          style: appTheme.themeData.primaryTextTheme.subtitle1,
                        )
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: h / 100),
                        child: Text('بيانات التوصيل',
                            style:
                                appTheme.themeData.primaryTextTheme.headline3)),
                    CustomTextField(
                        controller: address,
                        label: 'العنوان',
                        selectedIcon: FontAwesomeIcons.addressCard,
                        selectedColor: Color.fromRGBO(38, 92, 126, 1.0),
                        borderColor: Colors.grey,
                        obscureText: false,
                        keyboardType: TextInputType.streetAddress,
                        hint: 'أدخل العنوان المراد تسلم المبلغ منه',
                        error: addressError,
                        width: w,
                        onChanged: null,
                        onSubmitted: onSubmittedAddress,
                        rightInfo: addressValidator(),
                        enableFormatters: false,
                        maxLines: 1),
                    CustomTextField(
                        controller: mobileNumber,
                        label: 'رقم الهاتف',
                        selectedIcon: FontAwesomeIcons.mobile,
                        selectedColor: Color.fromRGBO(38, 92, 126, 1.0),
                        borderColor: Colors.grey,
                        obscureText: false,
                        keyboardType: TextInputType.phone,
                        hint: 'أدخل رقم هاتفك',
                        error: mobileNumberError,
                        width: w,
                        onChanged: null,
                        onSubmitted: onSubmittedMobileNumber,
                        rightInfo: mobileNumberValidator(),
                        enableFormatters: true,
                        maxLines: 1),
                    CustomSpacing(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text('من',
                                style: appTheme
                                    .themeData.primaryTextTheme.headline4),
                            ElevatedButton(
                              onPressed: () => selectFromDate(context),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(appTheme
                                          .themeData
                                          .primaryTextTheme
                                          .bodyText1!
                                          .color!)),
                              child: Text(
                                '${intl.DateFormat('y-MM-dd').format(startCollectDate)}',
                                style: appTheme
                                    .themeData.primaryTextTheme.bodyText2,
                              ),
                            ),
                          ],
                        ),
                        Text('-',
                            style:
                                appTheme.themeData.primaryTextTheme.headline4),
                        Column(
                          children: [
                            Text('إلي',
                                style: appTheme
                                    .themeData.primaryTextTheme.headline4),
                            ElevatedButton(
                              onPressed: () => selectToDate(context),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(appTheme
                                          .themeData
                                          .primaryTextTheme
                                          .bodyText1!
                                          .color!)),
                              child: Text(
                                '${intl.DateFormat('y-MM-dd').format(endCollectDate)}',
                                style: appTheme
                                    .themeData.primaryTextTheme.bodyText2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Center(
                      child: dateError == null
                          ? SizedBox()
                          : Text(
                              dateError!,
                              style: appTheme
                                  .themeData.primaryTextTheme.subtitle2!
                                  .apply(color: Colors.red),
                            ),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (fullValidator()) {
                    print('good');
                  }
                },
                child: Text(
                  'تبرع',
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
}
