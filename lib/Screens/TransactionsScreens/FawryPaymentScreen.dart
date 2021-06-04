import 'package:ahed/Custom%20Widgets/CustomSpacing.dart';
import 'package:ahed/Custom%20Widgets/custom_textfield.dart';
import 'package:ahed/Shared%20Data/app_language.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:ahed/Shared%20Data/common_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class FawryPaymentScreen extends StatefulWidget {
  @override
  _FawryPaymentScreenState createState() => _FawryPaymentScreenState();
}

class _FawryPaymentScreenState extends State<FawryPaymentScreen> {
  double w, h;
  CommonData commonData;
  AppLanguage appLanguage;
  AppTheme appTheme;
  TextEditingController cardNumber = new TextEditingController();
  String cardNumberError;
  TextEditingController expiryDate = new TextEditingController();
  String expiryDateError;
  TextEditingController cvv = new TextEditingController();
  String cvvError;
  TextEditingController amount = new TextEditingController();
  String amountError;

  bool fullValidator() {
    return onSubmittedCardNumber(cardNumber.text) &&
        onSubmittedExpiryDate(expiryDate.text) &&
        onSubmittedCVV(cvv.text) &&
        onSubmittedAmount(amount.text);
  }

  bool cardNumberValidator() {
    return onSubmittedCardNumber(cardNumber.text);
  }

  bool expiryDateValidator() {
    return onSubmittedExpiryDate(expiryDate.text);
  }

  bool cvvValidator() {
    return onSubmittedCVV(cvv.text);
  }

  bool amountValidator() {
    return onSubmittedAmount(amount.text);
  }

  onChangedCardNumber(String value) {}
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

  onChangedCVV(String value) {}
  onChangedAmount(String value) {}

  bool onSubmittedCardNumber(String value) {
    if (value.length == 0) {
      setState(() {
        cardNumberError = null;
      });
      return false;
    }
    if (value.length > 16 || value.length < 15) {
      setState(() {
        this.cardNumberError = "Card Number must be between 15 and 16 digits.";
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
        expiryDateError = null;
      });
      return false;
    }
    if (value.length < 5) {
      setState(() {
        expiryDateError = 'Invalid Date Format';
      });
      return false;
    }
    try {
      print(int.parse(value[0] + value[1]));
      int month = int.parse(value[0] + value[1]);
      int year = int.parse(value[3] + value[4]);
      if (month < 0 || month > 12) {
        setState(() {
          expiryDateError = 'Invalid Month';
        });
        return false;
      }
      int currentYear = int.parse(DateTime.now().year.toString()[2] +
          DateTime.now().year.toString()[3]);
      if (year < currentYear || year > currentYear + 10) {
        setState(() {
          expiryDateError = 'Invalid Year';
        });
        return false;
      }
    } catch (e) {
      setState(() {
        expiryDateError = 'Invalid Date Format';
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
        cvvError = null;
      });
      return false;
    }
    if (value.length < 3) {
      setState(() {
        cvvError = 'Invalid CVV';
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
    appTheme = Provider.of<AppTheme>(context);
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
                Padding(
                    padding: EdgeInsets.symmetric(vertical: h / 30),
                    child: Text('Payment Info',
                        style: appTheme.themeData.primaryTextTheme.headline1)),
                CustomSpacing(),
                CustomTextField(
                    controller: cardNumber,
                    label: 'Card Number',
                    selectedIcon: Entypo.credit_card,
                    selectedColor: Colors.grey,
                    borderColor: Colors.grey,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    hint: 'Enter Your Card Number',
                    error: cardNumberError,
                    width: w,
                    onChanged: onChangedCardNumber,
                    onSubmitted: onSubmittedCardNumber,
                    rightInfo: cardNumberValidator(),
                    enableFormatters: true,
                    maxLength: 16,
                    maxLines: 1),
                CustomTextField(
                    controller: expiryDate,
                    label: 'Expiry Date',
                    selectedIcon: AntDesign.calendar,
                    selectedColor: Colors.grey,
                    borderColor: Colors.grey,
                    obscureText: false,
                    keyboardType: TextInputType.datetime,
                    hint: '',
                    error: expiryDateError,
                    width: w / 2,
                    onChanged: onChangedExpiryDate,
                    onSubmitted: onSubmittedExpiryDate,
                    rightInfo: expiryDateValidator(),
                    enableFormatters: false,
                    maxLength: 5,
                    maxLines: 1),
                CustomTextField(
                    controller: cvv,
                    label: 'CVV',
                    selectedIcon: Entypo.credit_card,
                    selectedColor: Colors.grey,
                    borderColor: Colors.grey,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    hint: 'CVV',
                    error: cvvError,
                    width: w / 2.5,
                    onChanged: onChangedCVV,
                    onSubmitted: onSubmittedCVV,
                    rightInfo: cvvValidator(),
                    enableFormatters: true,
                    maxLength: 3,
                    maxLines: 1),
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
                CustomSpacing(),
                CustomSpacing(),
                CustomSpacing(),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Padding(
                      //   padding: EdgeInsets.only(left: w / 10),
                      //   child:
                      Text(
                        '-3LE\n-3% For Fawry Service',
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
                      ElevatedButton(
                        onPressed: () async {
                          if (fullValidator()) {
                            print('good');
                          }
                        },
                        child: Text('Donate'),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
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
