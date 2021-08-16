import 'package:ahed/ApiCallers/TransactionApiCaller.dart';
import 'package:ahed/Custom%20Widgets/CustomButtonLoading.dart';
import 'package:ahed/Custom%20Widgets/CustomSpacing.dart';
import 'package:ahed/Custom%20Widgets/custom_textfield.dart';
import 'package:ahed/Session/session_manager.dart';
import 'package:ahed/Shared%20Data/NeedyData.dart';
import 'package:ahed/Shared%20Data/app_language.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:ahed/Shared%20Data/common_data.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FawryPaymentScreen extends StatefulWidget {
  @override
  _FawryPaymentScreenState createState() => _FawryPaymentScreenState();
}

class _FawryPaymentScreenState extends State<FawryPaymentScreen> {
  late double w, h;
  late CommonData commonData;
  late NeedyData needyData;
  late AppLanguage appLanguage;
  late AppTheme appTheme;
  final TextEditingController cardNumber = new TextEditingController();
  String? cardNumberError;
  final TextEditingController expiryDate = new TextEditingController();
  String? expiryDateError;
  final TextEditingController cvv = new TextEditingController();
  String? cvvError;
  final TextEditingController amount = new TextEditingController();
  String? amountError;
  bool isLoading = false;

  bool fullValidator() {
    bool cardNumberValidation = onSubmittedCardNumber(cardNumber.text);
    bool expiryDateValidation = onSubmittedExpiryDate(expiryDate.text);
    bool cvvValidation = onSubmittedCVV(cvv.text);
    bool amountValidation = onSubmittedAmount(amount.text);
    return cardNumberValidation &&
        expiryDateValidation &&
        cvvValidation &&
        amountValidation;
  }


  onChangedExpiryDate(String value) {
    if (value.length == 0) {
      return setState(() {
        expiryDateError = null;
      });
    }
    if (value.length > 2 && value.contains('/')) {
    } else if (value.length == 3 && !value.contains('/')) {
      setState(() {
        expiryDate.text = value[0] + value[1] + "/" + value[2];
        expiryDate.selection = TextSelection.fromPosition(
            TextPosition(offset: expiryDate.text.length));
      });
    }
  }


  bool onSubmittedCardNumber(String value) {
    if (value.length == 0) {
      setState(() {
        cardNumberError = "هذا الحقل لا يمكن أن يكون فارغاً.";
      });
      return false;
    }
    if (value.length > 16 || value.length < 15) {
      setState(() {
        this.cardNumberError = "يجب أن يكون بين 15-16 رقماً";
      });
      return false;
    }
    setState(() {
      this.cardNumberError = null;
    });
    return true;
  }

  bool onSubmittedExpiryDate(String value) {
    if (value.length == 0) {
      setState(() {
        expiryDateError = "هذا الحقل لا يمكن أن يكون فارغاً.";
      });
      return false;
    }
    if (value.length < 5) {
      setState(() {
        expiryDateError = 'خطأ في التاريخ';
      });
      return false;
    }
    try {
      print(int.parse(value[0] + value[1]));
      int month = int.parse(value[0] + value[1]);
      int year = int.parse(value[3] + value[4]);
      if (month < 0 || month > 12) {
        setState(() {
          expiryDateError = 'خطأ في الشهر';
        });
        return false;
      }
      int currentYear = int.parse(DateTime.now().year.toString()[2] +
          DateTime.now().year.toString()[3]);
      if (year < currentYear || year > currentYear + 10) {
        setState(() {
          expiryDateError = 'خطأ في السنة';
        });
        return false;
      }
    } catch (e) {
      setState(() {
        expiryDateError = 'خطأ في إدخال التاريخ';
      });
      return false;
    }
    setState(() {
      this.expiryDateError = null;
    });
    return true;
  }

  bool onSubmittedCVV(String value) {
    if (value.length == 0) {
      setState(() {
        cvvError = "رقم خاطئ.";
      });
      return false;
    }
    if (value.length < 3) {
      setState(() {
        cvvError = 'رقم خاطئ';
      });
      return false;
    }
    setState(() {
      cvvError = null;
    });
    print(true);
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
      print(amount);
    } catch (e) {
      setState(() {
        amountError = "مبلغ خاطئ";
      });
      return false;
    }
    setState(() {
      amountError = null;
    });
    return true;
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
    needyData = Provider.of<NeedyData>(context);
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return GestureDetector(
        onTap: () {
          onSubmittedCardNumber(cardNumber.text);
          onSubmittedAmount(amount.text);
          onSubmittedCVV(cvv.text);
          onSubmittedExpiryDate(expiryDate.text);
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
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
                CustomSpacing(value: 50),
                CustomTextField(
                    controller: cardNumber,
                    label: 'رقم بطاقة الدفع',
                    selectedIcon: FontAwesomeIcons.creditCard,
                    selectedColor: Colors.grey,
                    borderColor: Colors.grey,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    hint: 'أدخل رقم بطاقة الدفع',
                    error: cardNumberError,
                    width: w,
                    onSubmitted: onSubmittedCardNumber,
                    enableFormatters: true,
                    maxLength: 16,
                    maxLines: 1),
                CustomTextField(
                    controller: expiryDate,
                    label: 'تاريخ نهاية البطاقة',
                    selectedIcon: FontAwesomeIcons.calendar,
                    selectedColor: Colors.grey,
                    borderColor: Colors.grey,
                    obscureText: false,
                    keyboardType: TextInputType.datetime,
                    hint: '',
                    error: expiryDateError,
                    width: w / 2,
                    onChanged: onChangedExpiryDate,
                    onSubmitted: onSubmittedExpiryDate,
                    enableFormatters: false,
                    maxLength: 5,
                    maxLines: 1),
                CustomTextField(
                    controller: cvv,
                    label: 'CVV',
                    selectedIcon: FontAwesomeIcons.creditCard,
                    selectedColor: Colors.grey,
                    borderColor: Colors.grey,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    hint: 'CVV',
                    error: cvvError,
                    width: w / 2.5,
                    onSubmitted: onSubmittedCVV,
                    enableFormatters: true,
                    maxLength: 3,
                    maxLines: 1),
                Row(
                  children: [
                    CustomTextField(
                        controller: amount,
                        label: 'المبلغ',
                        selectedIcon: FontAwesomeIcons.moneyBill,
                        selectedColor: Colors.grey,
                        borderColor: Colors.grey,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        hint: 'أدخل المبلغ',
                        error: amountError,
                        width: w / 2,
                        onSubmitted: onSubmittedAmount,
                        enableFormatters: false,
                        maxLines: 1),
                    SizedBox(
                      width: w / 100,
                    ),
                    Text('جنيه مصري')
                  ],
                ),
                CustomSpacing(
                  value: 100,
                ),
                // CustomSpacing(),
                // CustomSpacing(),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Padding(
                      //   padding: EdgeInsets.only(left: w / 10),
                      //   child:
                      Text(
                        '-3جنيهات\n-3% لخدمات فوري',
                        style: appTheme.nonStaticGetTextStyle(
                            1.0,
                            Colors.red,
                            appTheme.getBodyTextTheme(context),
                            FontWeight.w800,
                            1.0,
                            TextDecoration.none,
                            'Delius'),
                        // ),
                      ),
                      isLoading
                          ? CustomButtonLoading()
                          : ElevatedButton(
                              onPressed: () async {
                                print('h');
                                if (fullValidator()) {
                                  changeLoadingState();
                                  TransactionApiCaller transactionApiCaller =
                                      new TransactionApiCaller();
                                  SessionManager sessionManager =
                                      new SessionManager();
                                  Map<String, dynamic> status =
                                      await transactionApiCaller
                                          .addOnlineTransaction(
                                              sessionManager.user == null
                                                  ? null
                                                  : sessionManager.user!.id,
                                              needyData.selectedNeedy!.id!,
                                              int.parse(amount.text),
                                              cardNumber.text,
                                              expiryDate.text,
                                              cvv.text);
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
                              child: Text('تبرع'),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromRGBO(38, 92, 126, 1.0))),
                            ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
