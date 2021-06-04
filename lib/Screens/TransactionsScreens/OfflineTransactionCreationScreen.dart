import 'package:ahed/Custom%20Widgets/CustomSpacing.dart';
import 'package:ahed/Custom%20Widgets/custom_textfield.dart';
import 'package:ahed/Shared%20Data/app_language.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:ahed/Shared%20Data/common_data.dart';
import 'package:ahed/Shared%20Data/NeedyData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'FawryPaymentScreen.dart';

class OfflineTransactionCreationScreen extends StatefulWidget {
  @override
  _OfflineTransactionCreationScreenState createState() =>
      _OfflineTransactionCreationScreenState();
}

class _OfflineTransactionCreationScreenState
    extends State<OfflineTransactionCreationScreen> {
  double w, h;
  CommonData commonData;
  NeedyData needyData;
  AppLanguage appLanguage;
  AppTheme appTheme;
  TextEditingController amount = new TextEditingController();
  String amountError;
  String preferredSection;
  TextEditingController address = new TextEditingController();
  String addressError;
  DateTime startCollectDate = DateTime.now();
  DateTime endCollectDate = DateTime.now();

  // bool fullValidator() {
  //   return onSubmittedAmount(amount.text) &&
  //       onSubmittedAddress(address.text) &&
  //       onSubmittedSelectedDates(startCollectDate, endCollectDate);
  // }
  //
  // bool datesValidator() {
  //   return onSubmittedSelectedDates(startCollectDate, endCollectDate);
  // }

  bool amountValidator() {
    return onSubmittedAmount(amount.text);
  }

  // bool addressValidator() {
  //   return onSubmittedAddress(address.text);
  // }
  //
  // onChangedCardNumber(String value) {}
  // onChangedExpiryDate(String value) {
  //   if (value.length == 0) {
  //     return setState(() {
  //       expiryDateError = null;
  //     });
  //   }
  //   if (value.length > 2 && value.contains('/')) {
  //   } else if (value.length == 3 && !value.contains('/')) {
  //     setState(() {
  //       expiryDate.text = value[0] + value[1] + "/" + value[2];
  //       expiryDate.selection = TextSelection.fromPosition(
  //           TextPosition(offset: expiryDate.text.length));
  //     });
  //   }
  // }
  //
  // onChangedCVV(String value) {}
  onChangedAmount(String value) {}
  //
  // bool onSubmittedSelectedDates(String value) {
  //   if (value.length == 0) {
  //     setState(() {
  //       expiryDateError = null;
  //     });
  //     return false;
  //   }
  //   if (value.length < 5) {
  //     setState(() {
  //       expiryDateError = 'Invalid Date Format';
  //     });
  //     return false;
  //   }
  //   try {
  //     print(int.parse(value[0] + value[1]));
  //     int month = int.parse(value[0] + value[1]);
  //     int year = int.parse(value[3] + value[4]);
  //     if (month < 0 || month > 12) {
  //       setState(() {
  //         expiryDateError = 'Invalid Month';
  //       });
  //       return false;
  //     }
  //     int currentYear = int.parse(DateTime.now().year.toString()[2] +
  //         DateTime.now().year.toString()[3]);
  //     if (year < currentYear || year > currentYear + 10) {
  //       setState(() {
  //         expiryDateError = 'Invalid Year';
  //       });
  //       return false;
  //     }
  //   } catch (e) {
  //     setState(() {
  //       expiryDateError = 'Invalid Date Format';
  //     });
  //     return false;
  //   }
  //   setState(() {
  //     this.expiryDateError = null;
  //   });
  //   return true;
  // }
  //
  // bool onSubmittedAddress(String value) {
  //   if (value.length == 0) {
  //     setState(() {
  //       cvvError = null;
  //     });
  //     return false;
  //   }
  //   if (value.length < 3) {
  //     setState(() {
  //       cvvError = 'Invalid CVV';
  //     });
  //     return false;
  //   }
  //   setState(() {
  //     cvvError = null;
  //   });
  //   print(true);
  //   return true;
  // }
  //
  bool onSubmittedAmount(String value) {
    try {
      double amount = double.parse(value);
      if (amount < 1) {
        setState(() {
          amountError = "Zero?";
        });
        return false;
      }
      print(amount);
    } catch (e) {
      setState(() {
        amountError = "Invalid Amount";
      });
      return false;
    }
    setState(() {
      amountError = null;
    });
    return true;
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
          leading: IconButton(
              onPressed: () => commonData.back(),
              icon: Icon(
                Icons.arrow_back_ios_sharp,
                color: Colors.white,
              )),
          title: Text(
            'Donate',
            style: appTheme.nonStaticGetTextStyle(
                1.0,
                Colors.white,
                appTheme.getTextTheme(context),
                FontWeight.w600,
                1.0,
                TextDecoration.none,
                'Delius'),
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(38, 92, 126, 1.0),
          elevation: 0.0),
      backgroundColor: Color.fromRGBO(38, 92, 126, 1.0),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: w / 10),
        width: w,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: h / 30),
                  child: Text('Payment Info',
                      style: appTheme.themeData.primaryTextTheme.headline1)),
              Row(
                children: [
                  Container(child: Text('Needy: ')),
                  Container(child: Text('${needyData.selectedNeedy.name}')),
                ],
              ),
              CustomSpacing(),
              Row(
                children: [
                  Container(child: Text('Section: ')),
                  Container(child: Text('${needyData.selectedNeedy.type}')),
                ],
              ),
              CustomSpacing(),
              Row(
                children: [
                  Container(child: Text('Severity: ')),
                  Container(
                      child: Text('${needyData.selectedNeedy.severityClass}')),
                ],
              ),
              CustomSpacing(),
              Row(
                children: [
                  Container(child: Text('Details: ')),
                  Container(child: Text('${needyData.selectedNeedy.details}')),
                ],
              ),
              CustomSpacing(),
              Row(
                children: [
                  Container(child: Text('Money Left: ')),
                  LinearPercentIndicator(
                    width: 170.0,
                    alignment: MainAxisAlignment.center,
                    animation: true,
                    animationDuration: 1000,
                    lineHeight: h / 40,
                    linearGradient: LinearGradient(
                        colors: [Colors.green, Colors.greenAccent]),
                    percent: needyData.selectedNeedy.collected /
                        needyData.selectedNeedy.need,
                    center: Text(
                      (needyData.selectedNeedy.need -
                                  needyData.selectedNeedy.collected)
                              .toStringAsFixed(0) +
                          ' EGP Left',
                      style: appTheme.nonStaticGetTextStyle(
                          1.0,
                          Colors.white,
                          appTheme.getBodyTextTheme(context),
                          FontWeight.bold,
                          1.0,
                          TextDecoration.none,
                          'OpenSans'),
                    ),
                    linearStrokeCap: LinearStrokeCap.butt,
                  ),
                ],
              ),
              CustomSpacing(),
              Row(
                children: [
                  CustomTextField(
                      controller: amount,
                      label: 'Amount',
                      selectedIcon: FontAwesome.money,
                      selectedColor: Colors.grey,
                      borderColor: Colors.grey,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      hint: 'Enter the amount of money you wanna donate',
                      error: amountError,
                      width: w / 2,
                      onChanged: onChangedAmount,
                      onSubmitted: onSubmittedAmount,
                      rightInfo: amountValidator(),
                      enableFormatters: false,
                      maxLines: 1),
                  SizedBox(
                    width: w / 100,
                  ),
                  Text('EGP')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
