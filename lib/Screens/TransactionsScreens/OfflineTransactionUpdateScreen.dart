import 'package:ahed/ApiCallers/TransactionApiCaller.dart';
import 'package:ahed/Custom%20Widgets/CustomButtonLoading.dart';
import 'package:ahed/Custom%20Widgets/CustomSpacing.dart';
import 'package:ahed/Custom%20Widgets/custom_textfield.dart';
import 'package:ahed/Models/Needy.dart';
import 'package:ahed/Models/OfflineTransaction.dart';
import 'package:ahed/Session/session_manager.dart';
import 'package:ahed/Shared%20Data/NeedyData.dart';
import 'package:ahed/Shared%20Data/TransactionData.dart';
import 'package:ahed/Shared%20Data/app_language.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:ahed/Shared%20Data/common_data.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart' as intl;
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class OfflineTransactionUpdateScreen extends StatefulWidget {
  @override
  _OfflineTransactionUpdateScreenState createState() =>
      _OfflineTransactionUpdateScreenState();
}

class _OfflineTransactionUpdateScreenState
    extends State<OfflineTransactionUpdateScreen> {
  late double w, h;
  late CommonData commonData;
  late NeedyData needyData;
  late TransactionData transactionData;
  late AppLanguage appLanguage;
  late AppTheme appTheme;
  late TextEditingController amount;
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
    print('h');
    print(startCollectDate);
    print(endCollectDate);
    print(endCollectDate.isAfter(startCollectDate));
    if (endCollectDate.isAfter(startCollectDate)) {
      setState(() {
        dateError = '';
      });
      return true;
    }
    setState(() {
      dateError = "?????? ???? ???????????? ????????????";
    });
    return false;
  }

  bool onSubmittedAddress(String value) {
    if (value.length == 0) {
      setState(() {
        addressError = '?????????????? ???? ???????? ???? ???????? ????????????';
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
          amountError = "????????";
        });
        return false;
      }
    } catch (e) {
      setState(() {
        amountError = "?????????? ?????????? ???????? ??????????";
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
        mobileNumberError = '?????? ???????????? ???? ???????? ???? ???????? ????????????';
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
    transactionData = Provider.of<TransactionData>(context);
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    if (firstTime) {
      amount = new TextEditingController(
          text: transactionData.selectedTransaction!.amount.toInt().toString());
      address = new TextEditingController(
          text: transactionData.selectedTransaction!.address);
      mobileNumber = new TextEditingController(
          text: transactionData.selectedTransaction!.phoneNumber);
      startCollectDate = transactionData.selectedTransaction!.startCollectDate;
      endCollectDate = transactionData.selectedTransaction!.endCollectDate;
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
            '????????',
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
                    left: w / 10, right: w / 10, top: h / 100, bottom: h / 200),
                width: w,
                // height: double.infinity
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('?????? ????????????: ',
                            style:
                                appTheme.themeData.primaryTextTheme.headline5),
                        Text('${needyData.selectedNeedy!.name}',
                            style:
                                appTheme.themeData.primaryTextTheme.headline5),
                      ],
                    ),
                    CustomSpacing(
                      value: 100,
                    ),
                    Row(
                      children: [
                        Text('?????? ????????????: ',
                            style:
                                appTheme.themeData.primaryTextTheme.headline5),
                        Text('${needyData.selectedNeedy!.type}',
                            style:
                                appTheme.themeData.primaryTextTheme.headline5),
                      ],
                    ),
                    CustomSpacing(
                      value: 100,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: h/5,
                          minHeight: h/10
                      ),
                      child: SingleChildScrollView(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('????????????????: ',
                                style: appTheme
                                    .themeData.primaryTextTheme.headline5),
                            Flexible(
                              child: Text(
                                '${needyData.selectedNeedy!.details}',
                                style: appTheme
                                    .themeData.primaryTextTheme.headline5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomSpacing(
                      value: 100,
                    ),
                    Row(
                      children: [
                        Text('??????????????: ',
                            style:
                                appTheme.themeData.primaryTextTheme.headline5),
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
                                ' ????????',
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
                        child: Text('???????????? ??????????',
                            style:
                                appTheme.themeData.primaryTextTheme.headline3)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextField(
                            controller: amount,
                            label: '????????????',
                            selectedIcon: FontAwesomeIcons.moneyBill,
                            selectedColor: Color.fromRGBO(38, 92, 126, 1.0),
                            borderColor: Colors.grey,
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            hint: '?????????? ?????????? ???????????? ???????????? ???????????? ????',
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
                          '???????? ????????',
                          style: appTheme.themeData.primaryTextTheme.subtitle1,
                        )
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: h / 100),
                        child: Text('???????????? ??????????????',
                            style:
                                appTheme.themeData.primaryTextTheme.headline3)),
                    CustomTextField(
                        controller: address,
                        label: '??????????????',
                        selectedIcon: FontAwesomeIcons.addressCard,
                        selectedColor: Color.fromRGBO(38, 92, 126, 1.0),
                        borderColor: Colors.grey,
                        obscureText: false,
                        keyboardType: TextInputType.streetAddress,
                        hint: '???????? ?????????????? ???????????? ???????? ???????????? ??????',
                        error: addressError,
                        width: w,
                        onChanged: null,
                        onSubmitted: onSubmittedAddress,
                        enableFormatters: false,
                        maxLines: 1),
                    CustomTextField(
                        controller: mobileNumber,
                        label: '?????? ????????????',
                        selectedIcon: FontAwesomeIcons.phoneAlt,
                        selectedColor: Color.fromRGBO(38, 92, 126, 1.0),
                        borderColor: Colors.grey,
                        obscureText: false,
                        keyboardType: TextInputType.phone,
                        hint: '???????? ?????? ??????????',
                        error: mobileNumberError,
                        width: w,
                        onChanged: null,
                        onSubmitted: onSubmittedMobileNumber,
                        enableFormatters: true,
                        maxLines: 1),
                    CustomSpacing(
                      value: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text('????',
                                style: appTheme
                                    .themeData.primaryTextTheme.headline5),
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
                                appTheme.themeData.primaryTextTheme.headline5),
                        Column(
                          children: [
                            Text('??????',
                                style: appTheme
                                    .themeData.primaryTextTheme.headline5),
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
                        child: Text(
                      '*?????? ???? ???????? ???????????? ?????? ?????????????????? ?????? ?????? ??????????*',
                      style: appTheme.themeData.primaryTextTheme.subtitle1,
                    )),
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
              isLoading
                  ? CustomButtonLoading()
                  : ElevatedButton(
                      onPressed: () async {
                        if (fullValidator()) {
                          changeLoadingState();
                          TransactionApiCaller transactionApiCaller =
                              new TransactionApiCaller();
                          SessionManager sessionManager = new SessionManager();
                          Map<String, dynamic> status =
                              await transactionApiCaller
                                  .updateOfflineTransaction(
                                      sessionManager.user == null
                                          ? null
                                          : sessionManager.user!.id,
                                      transactionData.selectedTransaction!.id,
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
                        '??????????',
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
