// ignore_for_file: use_build_context_synchronously

import 'package:ahed/ApiCallers/TransactionApiCaller.dart';
import 'package:ahed/Custom%20Widgets/CustomButtonLoading.dart';
import 'package:ahed/Custom%20Widgets/CustomSpacing.dart';
import 'package:ahed/Custom%20Widgets/custom_textfield.dart';
import 'package:ahed/Session/session_manager.dart';
import 'package:ahed/Shared%20Data/app_language.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:ahed/Shared%20Data/common_data.dart';
import 'package:ahed/Shared%20Data/NeedyData.dart';
import 'package:cool_alert/cool_alert.dart';
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
  final TextEditingController amount = TextEditingController();
  late String preferredSection;
  late TextEditingController address;
  late TextEditingController mobileNumber;
  String? amountError;
  String? addressError;
  String? mobileNumberError;
  String? dateError;
  DateTime startCollectDate = DateTime.now();
  DateTime endCollectDate = DateTime.now();
  bool firstTime = true;
  bool isLoading = false;

  bool fullValidator() {
    bool amountValidation = onSubmittedAmount(amount.text);
    bool addressValidation = onSubmittedAddress(address.text);
    bool mobileNumberValidation = onSubmittedMobileNumber(mobileNumber.text);
    bool datesValidation =
        onSubmittedSelectedDates(startCollectDate, endCollectDate);
    return amountValidation &&
        addressValidation &&
        mobileNumberValidation &&
        datesValidation;
  }

  bool onSubmittedSelectedDates(
      DateTime startCollectDate, DateTime endCollectDate) {
    if (endCollectDate.isAfter(startCollectDate)) {
      setState(() {
        dateError = '';
      });
      return true;
    }
    setState(() {
      dateError = 'خطأ في إختيار الفترة';
    });
    return false;
  }

  bool onSubmittedAddress(String value) {
    if (value.isEmpty) {
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
          amountError = 'صفر؟';
        });
        return false;
      }
    } catch (e) {
      setState(() {
        amountError = 'برجاء إدخال قيمة صحيحة';
      });
      return false;
    }
    setState(() {
      amountError = null;
    });
    return true;
  }

  bool onSubmittedMobileNumber(String value) {
    if (value.isEmpty) {
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
    if (picked != null && picked != startCollectDate) {
      setState(() {
        startCollectDate = picked;
      });
    }
  }

  Future<void> selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: endCollectDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != endCollectDate) {
      setState(() {
        endCollectDate = picked;
      });
    }
  }

  changeLoadingState() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    commonData = Provider.of<CommonData>(context);
    needyData = Provider.of<NeedyData>(context);
    appTheme = Provider.of<AppTheme>(context);
    appLanguage = Provider.of<AppLanguage>(context);
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    if (firstTime) {
      SessionManager sessionManager = SessionManager();
      if (sessionManager.user == null) {
        address = TextEditingController();
        mobileNumber = TextEditingController();
      } else {
        print(sessionManager.user!.address == 'null');
        address = TextEditingController(text: sessionManager.user!.address);
        mobileNumber =
            TextEditingController(text: sessionManager.user!.phoneNumber);
      }
      firstTime = false;
    }
    return Scaffold(
      backgroundColor: appTheme.themeData.primaryColor,
      appBar: AppBar(
        backgroundColor: appTheme.themeData.primaryColor,
        elevation: 0.0,
        title: Padding(
          padding: EdgeInsets.only(top: h / 20, bottom: h / 40),
          child: Text(
            'تبرع',
            style: appTheme.themeData.primaryTextTheme.displayMedium,
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
      body: SizedBox(
        // width: w,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: w / 10, right: w / 10, top: h / 100, bottom: h / 200),
                width: w,
                // height: double.infinity
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('أسم الحالة: ',
                            style:
                                appTheme.themeData.primaryTextTheme.headlineSmall),
                        Flexible(
                          child: Text('${needyData.selectedNeedy!.name}',
                              style: appTheme
                                  .themeData.primaryTextTheme.headlineSmall),
                        ),
                      ],
                    ),
                    const CustomSpacing(
                      value: 100,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('نوع الحالة: ',
                            style:
                                appTheme.themeData.primaryTextTheme.headlineSmall),
                        Flexible(
                          child: Text('${needyData.selectedNeedy!.type}',
                              style: appTheme
                                  .themeData.primaryTextTheme.headlineSmall),
                        ),
                      ],
                    ),
                    const CustomSpacing(
                      value: 100,
                    ),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints(maxHeight: h / 5, minHeight: h / 10),
                      child: SingleChildScrollView(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('التفاصيل: ',
                                style: appTheme
                                    .themeData.primaryTextTheme.headlineSmall),
                            Flexible(
                              child: Text(
                                '${needyData.selectedNeedy!.details}',
                                style: appTheme
                                    .themeData.primaryTextTheme.headlineSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const CustomSpacing(
                      value: 100,
                    ),
                    Row(
                      children: [
                        Text('المتبقي: ',
                            style:
                                appTheme.themeData.primaryTextTheme.headlineSmall),
                        LinearPercentIndicator(
                          width: w / 2,
                          alignment: MainAxisAlignment.center,
                          animation: true,
                          padding: EdgeInsets.symmetric(vertical: h / 100),
                          animationDuration: 1000,
                          lineHeight: h / 25,
                          linearGradient: const LinearGradient(
                              colors: [Colors.green, Colors.greenAccent]),
                          percent: needyData.selectedNeedy!.collected! /
                              needyData.selectedNeedy!.need!,
                          center: Text(
                            '${(needyData.selectedNeedy!.need! - needyData.selectedNeedy!.collected!).toStringAsFixed(0)} جنيه',
                            style:
                                appTheme.themeData.primaryTextTheme.bodyMedium,
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
                                appTheme.themeData.primaryTextTheme.displaySmall)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextField(
                            controller: amount,
                            label: 'المبلغ',
                            selectedIcon: FontAwesomeIcons.moneyBill,
                            selectedColor:
                                const Color.fromRGBO(38, 92, 126, 1.0),
                            borderColor: Colors.grey,
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            hint: 'برجاء إدخال المبلغ المراد التبرع به',
                            error: amountError,
                            width: w / 2,
                            onChanged: null,
                            onSubmitted: onSubmittedAmount,
                            enableFormatters: true,
                            maxLines: 1),
                        SizedBox(
                          width: w / 100,
                        ),
                        Text(
                          'جنيه مصري',
                          style: appTheme.themeData.primaryTextTheme.titleMedium,
                        )
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: h / 100),
                        child: Text('بيانات التوصيل',
                            style:
                                appTheme.themeData.primaryTextTheme.displaySmall)),
                    CustomTextField(
                        controller: address,
                        label: 'العنوان',
                        selectedIcon: FontAwesomeIcons.addressCard,
                        selectedColor: const Color.fromRGBO(38, 92, 126, 1.0),
                        borderColor: Colors.grey,
                        obscureText: false,
                        keyboardType: TextInputType.streetAddress,
                        hint: 'أدخل العنوان المراد تسلم المبلغ منه',
                        error: addressError,
                        width: w,
                        onChanged: null,
                        onSubmitted: onSubmittedAddress,
                        enableFormatters: false,
                        maxLines: 1),
                    CustomTextField(
                        controller: mobileNumber,
                        label: 'رقم الهاتف',
                        selectedIcon: FontAwesomeIcons.phoneAlt,
                        selectedColor: const Color.fromRGBO(38, 92, 126, 1.0),
                        borderColor: Colors.grey,
                        obscureText: false,
                        keyboardType: TextInputType.phone,
                        hint: 'أدخل رقم هاتفك',
                        error: mobileNumberError,
                        width: w,
                        onChanged: null,
                        onSubmitted: onSubmittedMobileNumber,
                        enableFormatters: true,
                        maxLines: 1),
                    const CustomSpacing(
                      value: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text('من',
                                style: appTheme
                                    .themeData.primaryTextTheme.headlineSmall),
                            ElevatedButton(
                              onPressed: () => selectFromDate(context),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(appTheme
                                          .themeData
                                          .primaryTextTheme
                                          .bodyLarge!
                                          .color!)),
                              child: Text(
                                intl.DateFormat('y-MM-dd')
                                    .format(startCollectDate),
                                style: appTheme
                                    .themeData.primaryTextTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                        Text('-',
                            style:
                                appTheme.themeData.primaryTextTheme.headlineSmall),
                        Column(
                          children: [
                            Text('إلي',
                                style: appTheme
                                    .themeData.primaryTextTheme.headlineSmall),
                            ElevatedButton(
                              onPressed: () => selectToDate(context),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(appTheme
                                          .themeData
                                          .primaryTextTheme
                                          .bodyLarge!
                                          .color!)),
                              child: Text(
                                intl.DateFormat('y-MM-dd')
                                    .format(endCollectDate),
                                style: appTheme
                                    .themeData.primaryTextTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Center(
                        child: Text(
                      '*يجب أن يكون الفارق بين التاريخين يوم علي الأقل*',
                      style: appTheme.themeData.primaryTextTheme.titleMedium,
                    )),
                    Center(
                      child: dateError == null
                          ? const SizedBox()
                          : Text(
                              dateError!,
                              style: appTheme
                                  .themeData.primaryTextTheme.titleSmall!
                                  .apply(color: Colors.red),
                            ),
                    )
                  ],
                ),
              ),
              isLoading
                  ? const CustomButtonLoading()
                  : ElevatedButton(
                      onPressed: () async {
                        if (fullValidator()) {
                          changeLoadingState();
                          TransactionApiCaller transactionApiCaller =
                              TransactionApiCaller();
                          SessionManager sessionManager = SessionManager();
                          Map<String, dynamic> status =
                              await transactionApiCaller.addOfflineTransaction(
                                  appLanguage.language!,
                                  sessionManager.user == null
                                      ? null
                                      : sessionManager.user!.id,
                                  needyData.selectedNeedy!.id!,
                                  needyData.selectedNeedy!.type!,
                                  mobileNumber.text,
                                  int.parse(amount.text),
                                  address.text,
                                  startCollectDate,
                                  endCollectDate);
                          changeLoadingState();
                          if (status['Err_Flag']) {
                            return CoolAlert.show(
                                context: context,
                                type: CoolAlertType.error,
                                lottieAsset:
                                    'assets/animations/38213-error.json',
                                text: status['Err_Desc'],
                                confirmBtnColor: const Color(0xff1c9691),
                                title: '');
                          }
                          commonData.back();
                          print('Created');
                          return CoolAlert.show(
                              context: context,
                              type: CoolAlertType.success,
                              lottieAsset:
                                  'assets/animations/6951-success.json',
                              text: status['message'],
                              confirmBtnColor: const Color(0xff1c9691),
                              title: '');
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(38, 92, 126, 1.0))),
                      child: Text(
                        'تبرع',
                        style: appTheme.themeData.primaryTextTheme.bodyMedium,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
